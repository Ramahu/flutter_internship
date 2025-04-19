import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../generated/l10n.dart';
import '../../lessons/widget/state_widget.dart';
import '../provider/accessory_notifier.dart';
import '../widget/accessory_list_widget.dart';

class AccessoryScreen extends ConsumerStatefulWidget {
  const AccessoryScreen({super.key});

  @override
  ConsumerState<AccessoryScreen> createState() => _AccessoryScreenState();
}

class _AccessoryScreenState extends ConsumerState<AccessoryScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  Timer? debounce;
  String? selectedType;

  @override
  void initState() {
    super.initState();
    final accessoryNotifier = ref.read(accessoryProvider.notifier);

    Future.microtask(() async {
      await accessoryNotifier.initial();
      // final allType =
          // ignore: use_build_context_synchronously
      //     AppLocalizations.of(context).all;

      // if (!accessoryNotifier.contentTypes.any((s) => s.isEmpty)) {
      //   accessoryNotifier.contentTypes.insert(0, allType);
      // }
      // setState(() {
      //   selectedType = allType;
      // });
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !accessoryNotifier.isFetching &&
          accessoryNotifier.hasMore) {
        accessoryNotifier.next();
      }
    });

    searchController.addListener(() {
      if (debounce?.isActive ?? false) debounce!.cancel();
      debounce = Timer(const Duration(milliseconds: 500), () {
        final query = searchController.text.trim();
        accessoryNotifier.setSearchQuery(query);
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    searchController.dispose();
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accessoryState = ref.watch(accessoryProvider);
    final accessoryNotifier = ref.read(accessoryProvider.notifier);

    return Scaffold(
      // subject drop down
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 48,
            child: DropdownButtonFormField<String>(
              value: selectedType,
              hint: Text(AppLocalizations.of(context).selectType),
              items: accessoryNotifier.contentTypes.map((type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      type,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (type) {
                setState(() => selectedType = type);
                accessoryNotifier.setTypeFilter(type);
              },
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ),
        ),
        elevation: 2,
      ),

      body: Column(
        children: [
          const SizedBox(height: 5),
          // Accessory list
          Expanded(
            child: accessoryState.when(
              loading: loadingWidget,
              error: (e, _) => errorWidget(e),
              data: (accessories) {
                if (accessories.isEmpty) {
                  return Center(
                      child: Text(
                          AppLocalizations.of(context).noAccessoryAvailable));
                }
                return accessoryListWidget(_scrollController, accessories, ref);
              },
            ),
          ),
        ],
      ),
    );
  }
}

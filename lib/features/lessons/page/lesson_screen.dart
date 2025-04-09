import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intern/features/lessons/widget/lesson_list_widget.dart';

import '../../../core/util/icons.dart';
import '../provider/lesson_notifier.dart';
import '../widget/state_widget.dart';

class LessonScreen extends ConsumerStatefulWidget {
  const LessonScreen({super.key});

  @override
  ConsumerState<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends ConsumerState<LessonScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  Timer? debounce;

  @override
  void initState() {
    super.initState();
    final lessonNotifier = ref.read(lessonProvider.notifier);

    Future.microtask(lessonNotifier.initial);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !lessonNotifier.isFetching &&
          lessonNotifier.hasMore) {
        lessonNotifier.next();
      }
    });

    searchController.addListener(() {
      if (debounce?.isActive ?? false) debounce!.cancel();
      debounce = Timer(const Duration(milliseconds: 500), () {
        final query = searchController.text.trim();
        lessonNotifier.search(query);
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
    final lessonState = ref.watch(lessonProvider);

    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 45,
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              labelText: 'Search lessons',
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(search),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: searchController.clear,
              ),
            ),
          ),
        ),
        elevation: 2,
      ),
      body: Column(
        children: [
          Expanded(
            child: lessonState.when(
              loading: loadingWidget,
              error: (e, _) => errorWidget(e),
              data: (lessons) {
                if (lessons.isEmpty) {
                  return const Center(child: Text('No lessons available.'));
                }
                return lessonsListWidget(_scrollController, lessons, ref);
              },
            ),
          ),
        ],
      ),
    );
  }
}

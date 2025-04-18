import 'package:flutter/material.dart';

import 'package:intern/features/lessons/widget/state_widget.dart';

import '../../../generated/l10n.dart';
import '../model/accessory_model.dart';
import '../provider/accessory_notifier.dart';

Widget accessoryListWidget(ScrollController scrollController,
        List<AccessoryModel> accessories, ref) =>
    ListView.separated(
      controller: scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: accessories.length + 1,
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 8,
        );
      },
      itemBuilder: (context, index) {
        if (index < accessories.length) {
          final accessory = accessories[index];
          return accessoryItem(accessory);
        } else {
          final accessoryNotifier = ref.read(accessoryProvider.notifier);
          final isLoadingMore = accessoryNotifier.isFetching;
          final hasMore = accessoryNotifier.hasMore;

          if (isLoadingMore) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: loadingWidget(),
            );
          } else if (!hasMore) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: Text(AppLocalizations.of(context).noAccessoryMore),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        }
      },
    );

Widget accessoryItem(AccessoryModel accessory) => Card(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListTile(
            title: Text(
              accessory.topic,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            // subtitle: Text(
            //   '${accessory.subject.name}\n'
            //   'Start: ${lesson.startTime}\n'
            //   'End: ${lesson.endTime}',
            // ),
            onTap: () {},
          ),
        ),
      ),
    );

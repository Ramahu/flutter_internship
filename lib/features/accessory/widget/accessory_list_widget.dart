import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

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
          return accessoryItem(accessory, context);
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

Widget accessoryItem(AccessoryModel accessory, context) => Card(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(children: [
            Expanded(
              child: Text(
                accessory.topic,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Spacer(),
            if (_isValid(accessory.images))
              IconButton(
                icon: const Icon(Icons.image_outlined),
                tooltip: AppLocalizations.of(context).viewImage,
                onPressed: () => GoRouter.of(context).pushNamed(
                  'imageViewer',
                  queryParameters: {'url': accessory.images},
                ),
              ),
            if (_isValid(accessory.videos))
              IconButton(
                icon: const Icon(Icons.play_circle_outline),
                tooltip:AppLocalizations.of(context).watchVideo,
                onPressed: () => {},
              ),
            if (_isValid(accessory.file))
              IconButton(
                  icon: const Icon(Icons.picture_as_pdf_outlined),
                  tooltip: AppLocalizations.of(context).openPDF,
                  onPressed: () => {}),
            if (_isValid(accessory.url))
              IconButton(
                icon: const Icon(Icons.link),
                tooltip:AppLocalizations.of(context).openLink,
                onPressed: () => {},
              ),
          ]),
        ),
      ),
    );

bool _isValid(dynamic content) {
  return content != null && content.toString().isNotEmpty;
}

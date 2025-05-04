import 'package:flutter/material.dart';

import 'package:intern/features/lessons/widget/state_widget.dart';

import '../../../core/router/app_routes.dart';
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
          child: ListTile(
            title: Text(
              accessory.topic,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17.0,
              ),
            ),
            subtitle: Wrap(spacing: 10, children: [
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
                  tooltip: AppLocalizations.of(context).watchVideo,
                  onPressed: () => GoRouter.of(context).pushNamed(
                    AppRoutes.videoPlayer.name,
                    queryParameters: {'url': accessory.videos},
                  ),
                ),
              if (_isValid(accessory.videos))
                IconButton(
                  icon: const Icon(Icons.video_collection),
                  tooltip: AppLocalizations.of(context).watchYoutube,
                  onPressed: () => GoRouter.of(context).pushNamed(
                    AppRoutes.youtubePlayer.name,
                    queryParameters: {'url': 'UDVtMYqUAyw'},
                  ),
                ),
              if (_isValid(accessory.file))
                IconButton(
                  icon: const Icon(Icons.picture_as_pdf_outlined),
                  tooltip: AppLocalizations.of(context).openPDF,
                  onPressed: () => GoRouter.of(context).pushNamed(
                    AppRoutes.pdfViewer.name,
                    queryParameters: {'url': accessory.file},
                  ),
                ),
              if (_isValid(accessory.audio))
                IconButton(
                  icon: const Icon(Icons.audio_file_outlined),
                  tooltip: AppLocalizations.of(context).playAudio,
                  onPressed: () => GoRouter.of(context).pushNamed(
                    AppRoutes.audioPlayer.name,
                    queryParameters: {'url': accessory.audio},
                  ),
                ),
              if (_isValid(accessory.ar))
                IconButton(
                  icon: const Icon(Icons.view_in_ar),
                  tooltip: AppLocalizations.of(context).modelViewer,
                  onPressed: () => GoRouter.of(context).pushNamed(
                    AppRoutes.modelViewer.name,
                    queryParameters: {'url': accessory.ar},
                  ),
                ),
            ]),
          ),
        ),
      ),
    );

bool _isValid(dynamic content) {
  return content != null && content.toString().isNotEmpty;
}

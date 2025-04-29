import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

import '../../../generated/l10n.dart';

class ModelViewerScreen extends ConsumerWidget {
  const ModelViewerScreen({super.key, required this.modelUrl});
  final String modelUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).modelViewer),
        elevation: 2,
      ),
      body: Center(
        child: ModelViewer(
          src: modelUrl,
          ar: true,
          autoRotate: true,
          cameraControls: true,
        ),
      ),
    );
  }
}

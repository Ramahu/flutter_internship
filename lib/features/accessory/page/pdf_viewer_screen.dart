import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../generated/l10n.dart';

class PdfViewerScreen extends ConsumerWidget {
  const PdfViewerScreen({super.key, required this.pdfUrl});
  final String pdfUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).pdfViewer),
        elevation: 2,
      ),
      body: SfPdfViewer.network(pdfUrl),
    );
  }
}

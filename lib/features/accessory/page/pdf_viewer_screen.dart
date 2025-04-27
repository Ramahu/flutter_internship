// import 'package:flutter/material.dart';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:pdfx/pdfx.dart';

// import '../../../generated/l10n.dart';

// class PdfViewerScreen extends ConsumerStatefulWidget {
//   const PdfViewerScreen({super.key, required this.pdfUrl});
//   final String pdfUrl;

//   @override
//   ConsumerState<PdfViewerScreen> createState() => _PdfViewerScreenState();
// }

// class _PdfViewerScreenState extends ConsumerState<PdfViewerScreen> {
//   late PdfControllerPinch pdfController;

//   @override
//   void initState() {
//     super.initState();
//     pdfController = PdfControllerPinch(
//       document: PdfDocument.openFile(
//           // widget.pdfUrl
//           'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf'),
//     );
//   }

//   @override
//   void dispose() {
//     pdfController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(AppLocalizations.of(context).pdfViewer),
//         elevation: 2,
//       ),
//       body: PdfViewPinch(
//         controller: pdfController,
//       ),
//     );
//   }
// }

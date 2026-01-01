import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerScreen extends StatelessWidget {
  final String pdfUrl;
  const PdfViewerScreen({super.key, required this.pdfUrl});

  @override
  Widget build(BuildContext context) {

    print("fileee ${pdfUrl}");
    return Scaffold(
      appBar: AppBar(
        title: const Text('عرض ملف العقد'),
      ),
      body: SfPdfViewer.network(pdfUrl),
    );
  }
}

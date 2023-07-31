import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class OpenPDF extends StatelessWidget {
  const OpenPDF({super.key, required this.localPath});

  final String localPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PDFView(filePath: localPath),
    );
  }
}

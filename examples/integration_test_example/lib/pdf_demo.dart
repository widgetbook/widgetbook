import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';

/// A component backed by the `pdfrx` plugin (PDFium).
///
/// The page is rasterized natively and painted onto the Flutter canvas —
/// content that stays blank under `flutter test`.
class PdfDemo extends StatelessWidget {
  const PdfDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: PdfViewer.asset('assets/sample.pdf'),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:video_player/video_player.dart';

/// M0 de-risk: does an on-device `integration_test` screenshot actually contain
/// the native-plugin content (a decoded video frame and a rendered PDF page),
/// which `flutter test` + OffsetLayer.toImage cannot capture?
void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('captures a decoded video_player frame', (tester) async {
    final controller = VideoPlayerController.asset('assets/sample.mp4');
    await controller.initialize();
    await controller.seekTo(const Duration(milliseconds: 1500));
    await controller.pause();

    await tester.pumpWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: VideoPlayer(controller),
            ),
          ),
        ),
      ),
    );

    // Let the texture receive the seeked frame.
    await tester.pump(const Duration(milliseconds: 800));
    await binding.takeScreenshot('m0_video');

    await controller.dispose();
  });

  testWidgets('captures a rendered pdfrx page', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          body: PdfViewer.asset('assets/sample.pdf'),
        ),
      ),
    );

    // PDFium loads and rasterizes the page asynchronously.
    for (var i = 0; i < 20; i++) {
      await tester.pump(const Duration(milliseconds: 200));
    }
    await binding.takeScreenshot('m0_pdf');
  });
}

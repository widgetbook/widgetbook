import 'dart:io';
import 'dart:ui' as ui;

import 'package:customer_issue_2018/widgetbook.config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/test.dart';

/// Solid color of `assets/images/knob.png`, owned by the `assets` package.
const _packageKnob = (255, 0, 255);

/// Solid color of `images/local_knob.png`, owned by this package.
const _localKnob = (0, 200, 0);

Future<void> main() async {
  final packageAssetSnapshot = File(
    'build/.widgetbook/SettingToggle/Default/Default.png',
  );
  final localAssetSnapshot = File(
    'build/.widgetbook/LocalAssetToggle/Default/Default.png',
  );

  for (final snapshot in [packageAssetSnapshot, localAssetSnapshot]) {
    if (snapshot.existsSync()) snapshot.deleteSync();
  }

  await testWidgetbook(config);

  test('the asset from the `assets` package is painted', () async {
    final colors = await _colorHistogram(packageAssetSnapshot);

    expect(
      colors[_packageKnob],
      isNotNull,
      reason: 'the knob is missing from ${packageAssetSnapshot.path}',
    );
  });

  test('the asset owned by this package is painted', () async {
    final colors = await _colorHistogram(localAssetSnapshot);

    expect(
      colors[_localKnob],
      isNotNull,
      reason: 'the knob is missing from ${localAssetSnapshot.path}',
    );
  });
}

Future<Map<(int, int, int), int>> _colorHistogram(File file) async {
  expect(file.existsSync(), isTrue, reason: 'no snapshot at ${file.path}');

  final codec = await ui.instantiateImageCodec(await file.readAsBytes());
  final frame = await codec.getNextFrame();
  final byteData = await frame.image.toByteData();
  final bytes = byteData!.buffer.asUint8List();

  final histogram = <(int, int, int), int>{};
  for (var i = 0; i < bytes.length; i += 4) {
    final color = (bytes[i], bytes[i + 1], bytes[i + 2]);
    histogram[color] = (histogram[color] ?? 0) + 1;
  }

  frame.image.dispose();
  codec.dispose();

  return histogram;
}

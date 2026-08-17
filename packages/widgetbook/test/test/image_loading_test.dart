import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/test/image_loader.dart';
import 'package:widgetbook/test.dart';
import 'package:widgetbook/widgetbook.dart';

/// 2x2 single-color PNGs, stretched to fill their box, so the snapshot either
/// contains a block of that color or nothing at all.
final _magentaBytes = base64Decode(
  'iVBORw0KGgoAAAANSUhEUgAAAAIAAAACCAYAAABytg0kAAAAEUlEQVR42mP4z/D/PwgzwBgAaagL'
  '9Uu86vkAAAAASUVORK5CYII=',
);
final _greenBytes = base64Decode(
  'iVBORw0KGgoAAAANSUhEUgAAAAIAAAACCAYAAABytg0kAAAAEElEQVR42mNgOMHwH4xhDAA7pAcd'
  'ZabKyQAAAABJRU5ErkJggg==',
);
final _transparentBytes = base64Decode(
  'iVBORw0KGgoAAAANSUhEUgAAAAIAAAACCAYAAABytg0kAAAAC0lEQVR42mNgQAcAABIAAeRVjecA'
  'AAAASUVORK5CYII=',
);

/// A separate byte list per image kind, since [MemoryImage] keys on the
/// identity of its bytes. Keeping them out of [_Images] leaves the two tests
/// with disjoint cache keys.
final _kinds = {
  'Image': Uint8List.fromList(_magentaBytes),
  'BoxDecoration': Uint8List.fromList(_magentaBytes),
  'ShapeDecoration': Uint8List.fromList(_magentaBytes),
  'Ink': Uint8List.fromList(_magentaBytes),
  'FadeInImage': Uint8List.fromList(_magentaBytes),
};

const _magenta = (255, 0, 255);
const _green = (0, 200, 0);

class _Images extends StatelessWidget {
  const _Images();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.memory(
          _magentaBytes,
          width: 20,
          height: 20,
          fit: BoxFit.fill,
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: MemoryImage(_greenBytes),
              fit: BoxFit.fill,
            ),
          ),
          child: const SizedBox.square(dimension: 20),
        ),
      ],
    );
  }
}

/// One widget per kind of image that [loadImages] is expected to reach.
///
/// A [FadeInImage]'s target is decoded like the others, but cannot be asserted
/// on in a snapshot since its fade needs time to advance.
class _AllImageKinds extends StatelessWidget {
  const _AllImageKinds();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.memory(_kinds['Image']!, width: 20, height: 20),
            DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: MemoryImage(_kinds['BoxDecoration']!),
                ),
              ),
              child: const SizedBox.square(dimension: 20),
            ),
            DecoratedBox(
              decoration: ShapeDecoration(
                shape: const CircleBorder(),
                image: DecorationImage(
                  image: MemoryImage(_kinds['ShapeDecoration']!),
                ),
              ),
              child: const SizedBox.square(dimension: 20),
            ),
            Ink.image(
              image: MemoryImage(_kinds['Ink']!),
              width: 20,
              height: 20,
            ),
            FadeInImage(
              placeholder: MemoryImage(_transparentBytes),
              image: MemoryImage(_kinds['FadeInImage']!),
              width: 20,
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class _ImagesArgs extends StoryArgs<_Images> {
  const _ImagesArgs();

  @override
  List<Arg?> get list => const [];
}

class _ImagesStory extends Story<_Images, _ImagesArgs> {
  _ImagesStory({super.scenarios})
    : super(
        name: 'Default',
        args: const _ImagesArgs(),
        builder: (context, args) => const _Images(),
      );
}

/// Whether the provider's image finished decoding, as opposed to merely having
/// been requested, which already adds a pending entry to the cache.
bool _isDecoded(Uint8List bytes) => PaintingBinding.instance.imageCache
    .statusForKey(MemoryImage(bytes))
    .keepAlive;

Future<void> main() async {
  final snapshot = File('build/.widgetbook/Images/Default/Loaded.png');
  if (snapshot.existsSync()) snapshot.deleteSync();

  final config = Config(
    components: [
      Component<_Images, _ImagesArgs>(
        name: 'Images',
        stories: [
          _ImagesStory(
            scenarios: [
              Scenario<_Images, _ImagesArgs>(name: 'Loaded'),
            ],
          ),
        ],
      ),
    ],
  );

  await testWidgetbook(config);

  test('testWidgetbook captures images into the snapshot', () async {
    expect(snapshot.existsSync(), isTrue, reason: 'no snapshot was written');

    final colors = await _colorHistogram(snapshot);

    expect(
      colors[_magenta],
      isNotNull,
      reason: "the Image's pixels are missing from the snapshot",
    );
    expect(
      colors[_green],
      isNotNull,
      reason: "the DecorationImage's pixels are missing from the snapshot",
    );
  });

  testWidgets('loadImages decodes every kind of mounted provider', (
    tester,
  ) async {
    addTearDown(() {
      final imageCache = PaintingBinding.instance.imageCache;
      imageCache.clear();
      imageCache.clearLiveImages();
    });

    await tester.pumpWidget(const _AllImageKinds());

    expect(
      _kinds.map((kind, bytes) => MapEntry(kind, _isDecoded(bytes))),
      _kinds.map((kind, _) => MapEntry(kind, false)),
      reason: 'pumping alone cannot decode images',
    );

    await loadImages(tester);

    expect(
      _kinds.map((kind, bytes) => MapEntry(kind, _isDecoded(bytes))),
      _kinds.map((kind, _) => MapEntry(kind, true)),
    );
  });
}

Future<Map<(int, int, int), int>> _colorHistogram(File file) async {
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

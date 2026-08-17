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
final _blueBytes = base64Decode(
  'iVBORw0KGgoAAAANSUhEUgAAAAIAAAACCAYAAABytg0kAAAAEElEQVR42mNgYPj/H4KhDAA/0gf5'
  'XBPgQgAAAABJRU5ErkJggg==',
);
final _transparentBytes = base64Decode(
  'iVBORw0KGgoAAAANSUhEUgAAAAIAAAACCAYAAABytg0kAAAAC0lEQVR42mNgQAcAABIAAeRVjecA'
  'AAAASUVORK5CYII=',
);

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

/// Adds a [FadeInImage], whose target image is decoded like the others, but
/// cannot be asserted on in a snapshot since its fade needs time to advance.
class _AllImageKinds extends StatelessWidget {
  const _AllImageKinds();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const _Images(),
          FadeInImage(
            placeholder: MemoryImage(_transparentBytes),
            image: MemoryImage(_blueBytes),
            width: 20,
            height: 20,
            fit: BoxFit.fill,
          ),
        ],
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
      [_magentaBytes, _greenBytes, _blueBytes].map(_isDecoded),
      everyElement(isFalse),
      reason: 'pumping alone cannot decode images',
    );

    await loadImages(tester);

    expect(_isDecoded(_magentaBytes), isTrue, reason: 'Image');
    expect(_isDecoded(_greenBytes), isTrue, reason: 'DecorationImage');
    expect(_isDecoded(_blueBytes), isTrue, reason: 'FadeInImage');
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

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
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
        FadeInImage(
          placeholder: MemoryImage(_magentaBytes),
          image: MemoryImage(_blueBytes),
          width: 20,
          height: 20,
          fit: BoxFit.fill,
        ),
      ],
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

ImageCache get _imageCache => PaintingBinding.instance.imageCache;

/// Whether the provider's image finished decoding, as opposed to merely having
/// been requested, which already adds a pending entry to the cache.
bool _isDecoded(Uint8List bytes) =>
    _imageCache.statusForKey(MemoryImage(bytes)).keepAlive;

Future<void> main() async {
  final snapshot = File('build/.widgetbook/Images/Default/Loaded.png');
  if (snapshot.existsSync()) snapshot.deleteSync();

  final decodedBeforeScenarioRuns = <String, bool>{};

  final scenario = Scenario<_Images, _ImagesArgs>(
    name: 'Loaded',
    run: (tester, args) async {
      decodedBeforeScenarioRuns.addAll({
        'Image': _isDecoded(_magentaBytes),
        'DecorationImage': _isDecoded(_greenBytes),
        'FadeInImage': _isDecoded(_blueBytes),
      });
    },
  );

  final config = Config(
    components: [
      Component<_Images, _ImagesArgs>(
        name: 'Images',
        stories: [
          _ImagesStory(scenarios: [scenario]),
        ],
      ),
    ],
  );

  await testWidgetbook(config);

  test('testWidgetbook loads images before running a scenario', () {
    expect(decodedBeforeScenarioRuns, {
      'Image': true,
      'DecorationImage': true,
      'FadeInImage': true,
    });
  });

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

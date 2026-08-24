import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Bounds a single load, so that a provider which never completes nor fails
/// cannot stall snapshot generation.
const _loadTimeout = Duration(seconds: 5);

/// Loads the images that mounted widgets expose, and waits until they decode.
///
/// Resolving an [ImageProvider] completes on the real event loop that
/// [WidgetTester.pump] does not advance, hence the runAsync below.
/// Call once before the scenario's interaction so it acts on the loaded layout,
/// and once after, for images the interaction mounted itself.
/// A failing provider reports through the widget's own stream and fails the
/// scenario, rather than being captured as an empty box.
Future<void> loadImages(WidgetTester tester) async {
  final targets = <(ImageProvider, Element)>[];

  for (final element in tester.allElements) {
    final provider = _providerOf(element.widget);

    if (provider != null) {
      targets.add((provider, element));
    }
  }

  if (targets.isEmpty) return;

  await TestWidgetsFlutterBinding.instance.runAsync(() async {
    await Future.wait([
      for (final (provider, context) in targets)
        precacheImage(
          provider,
          context,
          onError: (_, _) {},
        ).timeout(_loadTimeout, onTimeout: () {}),
    ]);
  });

  // Repaints with the decoded images, without advancing time.
  await tester.pump();
}

/// The image a widget paints, if it exposes one.
///
/// [FadeInImage] needs no case of its own, as it builds an [Image] for both its
/// target and its placeholder. Images that a widget keeps private, e.g. a
/// [CustomPainter] calling [paintImage], cannot be reached this way.
ImageProvider? _providerOf(Widget widget) => switch (widget) {
  Image(:final image) => image,
  DecoratedBox(:final decoration) => _decorationImage(decoration),
  DecoratedSliver(:final decoration) => _decorationImage(decoration),
  Ink(:final decoration) => _decorationImage(decoration),
  _ => null,
};

ImageProvider? _decorationImage(Decoration? decoration) => switch (decoration) {
  BoxDecoration(:final image) => image?.image,
  ShapeDecoration(:final image) => image?.image,
  _ => null,
};

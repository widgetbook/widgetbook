import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Bounds a single load, so that a provider which never completes nor fails
/// cannot stall snapshot generation.
const _loadTimeout = Duration(seconds: 5);

/// Loads the images that mounted widgets expose, and waits until they decode.
///
/// Resolving an [ImageProvider] reads bytes and instantiates a codec, both of
/// which complete on the real event loop that [WidgetTester.pump] does not
/// advance. Without [TestWidgetsFlutterBinding.runAsync], images never produce
/// a frame and stay absent from snapshots. Load failures are swallowed, since a
/// single unreachable image must not fail a snapshot.
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

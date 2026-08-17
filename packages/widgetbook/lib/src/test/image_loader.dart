import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// Loads the images of every mounted [Image], [FadeInImage] and
/// [DecorationImage], and waits until they are decoded.
///
/// Resolving an [ImageProvider] reads bytes and instantiates a codec, both of
/// which complete on the real event loop that [WidgetTester.pump] does not
/// advance. Without [TestWidgetsFlutterBinding.runAsync], images never produce
/// a frame and stay absent from snapshots. Load failures are swallowed, since a
/// single unreachable image must not fail a snapshot.
Future<void> loadImages(WidgetTester tester) async {
  final targets = <(ImageProvider, Element)>[];

  for (final element in find.byType(Image).evaluate()) {
    final widget = element.widget as Image;
    targets.add((widget.image, element));
  }

  for (final element in find.byType(FadeInImage).evaluate()) {
    final widget = element.widget as FadeInImage;
    targets.add((widget.image, element));
  }

  for (final element in find.byType(DecoratedBox).evaluate()) {
    final widget = element.widget as DecoratedBox;
    final decoration = widget.decoration;

    if (decoration is BoxDecoration && decoration.image != null) {
      targets.add((decoration.image!.image, element));
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
        ),
    ]);
  });

  // Repaints with the decoded images, without advancing time.
  await tester.pump();
}

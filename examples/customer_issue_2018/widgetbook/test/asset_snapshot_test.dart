import 'package:customer_issue_2018/local_asset_toggle.dart';
import 'package:customer_issue_2018/setting_toggle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

/// Solid color of `assets/images/knob.png`.
const packageKnobColor = (255, 0, 255);

/// Solid color of `images/local_knob.png`.
const localKnobColor = (0, 200, 0);

void main() {
  group('snapshot capture', () {
    testWidgets('paints an image from a dependency package', (tester) async {
      final key = UniqueKey();

      await tester.pumpWidget(
        _App(
          key: key,
          child: SettingToggle(
            title: 'Package asset',
            value: false,
            toggleFunction: () {},
          ),
        ),
      );

      expect(await _countColor(tester, key, packageKnobColor), greaterThan(0));
    });

    testWidgets('paints an image from the Widgetbook package', (tester) async {
      final key = UniqueKey();

      await tester.pumpWidget(
        _App(
          key: key,
          child: const LocalAssetToggle(
            title: 'Local asset',
            value: false,
          ),
        ),
      );

      expect(await _countColor(tester, key, localKnobColor), greaterThan(0));
    });

    testWidgets('paints both images once they are precached in an async gap', (
      tester,
    ) async {
      final key = UniqueKey();

      await tester.pumpWidget(
        _App(
          key: key,
          child: Column(
            children: [
              SettingToggle(
                title: 'Package asset',
                value: false,
                toggleFunction: () {},
              ),
              const LocalAssetToggle(
                title: 'Local asset',
                value: false,
              ),
            ],
          ),
        ),
      );

      final context = tester.element(find.byType(SettingToggle));

      await tester.runAsync(() async {
        await precacheImage(
          const AssetImage('images/knob.png', package: 'assets'),
          context,
        );
        await precacheImage(
          const AssetImage('images/local_knob.png'),
          context,
        );
      });

      await tester.pump();

      expect(await _countColor(tester, key, packageKnobColor), greaterThan(0));
      expect(await _countColor(tester, key, localKnobColor), greaterThan(0));
    });
  });
}

class _App extends StatelessWidget {
  const _App({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child: child),
      ),
    );
  }
}

/// Rasterizes the subtree below [key] the same way `testWidgetbook` does, and
/// counts the pixels matching [color].
Future<int> _countColor(
  WidgetTester tester,
  Key key,
  (int, int, int) color,
) async {
  var renderObject = tester.element(find.byKey(key)).renderObject!;
  while (!renderObject.isRepaintBoundary) {
    renderObject = renderObject.parent!;
  }

  final layer = renderObject.debugLayer! as OffsetLayer;
  final imageFuture = layer.toImage(renderObject.paintBounds);

  var matches = 0;

  await tester.binding.runAsync(() async {
    final image = await imageFuture;
    final byteData = await image.toByteData();

    final bytes = byteData!.buffer.asUint8List();
    for (var i = 0; i < bytes.length; i += 4) {
      final pixel = (bytes[i], bytes[i + 1], bytes[i + 2]);
      if (pixel == color) matches++;
    }

    image.dispose();
  });

  return matches;
}

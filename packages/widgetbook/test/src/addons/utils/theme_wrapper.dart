import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/addon.dart';
import 'package:widgetbook/src/addons/addon_injector_widget.dart';
import 'package:widgetbook/src/addons/addon_provider.dart';
import 'package:widgetbook/src/addons/frame_addon/frame_provider.dart';
import 'package:widgetbook/widgetbook.dart';

import 'addons.dart';
import 'custom_app_theme.dart';

Widget addOnProviderWrapper<T>({
  required Widget child,
  required List<WidgetbookAddOn> addons,
}) =>
    AddonInjectorWidget(
      addons: addons,
      routerData: const <String, dynamic>{},
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => AddOnProvider(
              addons,
            ),
          ),
        ],
        child: Builder(
          builder: (builder) => MediaQuery.fromWindow(
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: child,
            ),
          ),
        ),
      ),
    );

Future<void> ensureCorrectThemeIsRendered<T>({
  required WidgetTester tester,
  required Widget sut,
  required List<WidgetbookAddOn> addons,
}) async {
  await tester.pumpWidget(
    addOnProviderWrapper<T>(
      child: sut,
      addons: addons,
    ),
  );
  await tester.pumpAndSettle();

  final coloredBoxFinder = find.byKey(coloredBoxKey);
  expect(coloredBoxFinder, findsOneWidget);
  final coloredBox = coloredBoxFinder.evaluate().single.widget as ColoredBox;

  expect(coloredBox.color, equals(colorBlue));
}

Future<T> getSettingProvider<T>({
  required BuildContext context,
  required Key itemsKey,
}) async {
  final provider = context.read<T>();
  return provider;
}

Color coloredBoxColorList(Finder finder) {
  final coloredBox = finder.evaluate().first.widget as ColoredBox;
  return coloredBox.color;
}

void expectText({
  required String textData,
}) {
  final textFinder = find.byKey(textKey);

  final text = textFinder.evaluate().first.widget as Text;
  final currentText = text.data;

  expect(
    currentText,
    equals(
      textData,
    ),
  );
}

void expectThemeColor({
  required Color colorData,
}) {
  final coloredBoxFinder = find.byKey(coloredBoxKey);

  final color = coloredBoxFinder.evaluate().first.widget as ColoredBox;

  final currentThemeColor = color.color;

  expect(
    currentThemeColor,
    equals(
      colorData,
    ),
  );
}

void expectTextScale({
  required double textScales,
}) {
  final textFinder = find.byKey(textKey);

  final text = textFinder.evaluate().first.widget as Text;

  final currentTextScales = text.textScaleFactor;

  expect(
    currentTextScales,
    equals(
      textScales,
    ),
  );
}

void expectDevice({
  required String deviceName,
}) {
  final renderFinder = find.byKey(rendererKey);
  final deviceFrameFinder = find.byKey(const Key('device_frame'));

  final deviceFrame =
      find.descendant(of: renderFinder, matching: deviceFrameFinder);
  expect(deviceFrame, findsOneWidget);

  final deviceFrameElement = deviceFrame.evaluate().first.widget as DeviceFrame;

  final expectedDeviceName = deviceFrameElement.device.name;

  expect(
    deviceName,
    equals(
      expectedDeviceName,
    ),
  );
}

void expectWidgetbookFrame({
  required WidgetTester tester,
  required String expectedFrameName,
  required BuildContext context,
}) {
  final frame = context.read<FrameProvider>();

  final widgetbookFittedBoxFinder =
      find.byKey(const Key('widgetbook_device_edge_bond'));

  expect(widgetbookFittedBoxFinder, findsOneWidget);

  expect(
    frame.value.name,
    expectedFrameName,
  );
}

void expectNoFrame({
  required WidgetTester tester,
  required String expectedFrameName,
  required BuildContext context,
}) {
  final frame = context.read<FrameProvider>();

  final noFrameBuilderFinder = find.byKey(const Key('no_frame'));

  expect(noFrameBuilderFinder, findsOneWidget);

  expect(
    frame.value.name,
    expectedFrameName,
  );
}

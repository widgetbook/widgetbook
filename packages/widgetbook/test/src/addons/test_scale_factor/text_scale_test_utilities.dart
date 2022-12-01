import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/addon.dart';
import 'package:widgetbook/src/addons/text_scale_addon/text_scale_selection_provider.dart';

import '../utils/addons.dart';
import '../utils/custom_app_theme.dart';
import '../utils/theme_wrapper.dart';

TextScaleSettingProvider getTextScaleFactorSettingProvider(
  WidgetTester tester,
) {
  final BuildContext context = tester.element(
    find
        .byKey(
          textKey,
        )
        .first,
  );

  final provider = context.read<TextScaleSettingProvider>();
  return provider;
}

Future<void> ensureMultipleScaleFactorsRenderedSideBySide({
  required WidgetTester tester,
  required Widget sut,
  required WidgetbookAddOn addon,
  double? scaleFactor,
  bool checkSingleScaleFactor = false,
}) async {
  await tester.pumpWidget(
    addOnProviderWrapper<AppThemeData>(
      child: sut,
      addons: [addon],
    ),
  );

  scaleFactor != null
      ? getTextScaleFactorSettingProvider(tester).tapped(
          scaleFactor,
        )
      : null;

  await tester.pumpAndSettle();

  final textWidget = find.byKey(textKey);

  final text = textWidget.evaluate().map((e) {
    final coloredBox = e.widget as Text;
    return coloredBox.textScaleFactor;
  }).toList();

  expect(
    text.length,
    equals(
      checkSingleScaleFactor ? 1 : 2,
    ),
  );

  expect(
    text,
    equals(
      checkSingleScaleFactor
          ? [
              1,
            ]
          : [
              1,
              2,
            ],
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/addon.dart';
import 'package:widgetbook/src/addons/addon_injector_widget.dart';
import 'package:widgetbook/src/addons/addon_provider.dart';

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

Future<void> renderAddonSideBySide<T>({
  required WidgetTester tester,
  required Widget sut,
  required List<WidgetbookAddOn> addons,
  required List Function(Finder)? itemsCollection,
  required List? expectedValues,
  required Key itemsKey,
  Future Function(BuildContext T)? updateAddon,
  bool shouldUpdate = false,
}) async {
  await tester.pumpWidget(
    addOnProviderWrapper<T>(
      child: sut,
      addons: addons,
    ),
  );

  final BuildContext context = tester.element(
    find
        .byKey(
          itemsKey,
        )
        .first,
  );

  shouldUpdate ? await updateAddon!(context) : null;

  await tester.pumpAndSettle();

  final item = find.byKey(itemsKey);

  final items = itemsCollection!(item);

  expect(
    items,
    equals(
      expectedValues,
    ),
  );
}

Future<T> getSettingProvider<T>({
  required BuildContext context,
  required Key itemsKey,
}) async {
  final provider = context.read<T>();
  return provider;
}

List<Color?> coloredBoxColorList(Finder coloredBox) =>
    coloredBox.evaluate().map((e) {
      final coloredBox = e.widget as ColoredBox;
      return coloredBox.color;
    }).toList();

List<double?> textDoubleList(Finder text) => text.evaluate().map((e) {
      final text = e.widget as Text;
      return text.textScaleFactor;
    }).toList();

List<String?> textDataList(Finder text) => text.evaluate().map((e) {
      final text = e.widget as Text;
      return text.data;
    }).toList();
 
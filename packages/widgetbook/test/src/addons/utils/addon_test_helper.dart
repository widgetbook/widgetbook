import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/addons/addons.dart';
import 'package:widgetbook/src/state/state.dart';

import 'extensions/widget_tester_extension.dart';

Future<void> testAddon({
  required WidgetTester tester,
  required WidgetbookAddOn addon,
  required void Function(BuildContext context) expect,
  Future<void> Function()? act,
}) async {
  const key = ValueKey('RandomKey');

  await tester.pumpWidget(
    MaterialApp(
      home: WidgetbookScope(
        state: WidgetbookState(
          queryParams: {},
          addons: [addon],
          appBuilder: materialAppBuilder,
          catalog: WidgetbookCatalog.fromDirectories([]),
        ),
        child: Scaffold(
          body: Builder(
            key: key,
            builder: addon.buildSetting,
          ),
        ),
      ),
    ),
  );

  await act?.call();
  await tester.pumpAndSettle();

  final context = tester.findContextByKey(key);
  expect(context);
}

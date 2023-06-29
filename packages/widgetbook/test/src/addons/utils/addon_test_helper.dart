import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/addons/addons.dart';
import 'package:widgetbook/src/fields/fields.dart';
import 'package:widgetbook/src/state/state.dart';

Future<void> testAddon<T>({
  required WidgetTester tester,
  required WidgetbookAddon<T> addon,
  required void Function(T setting) expect,
  Future<void> Function()? act,
}) async {
  final state = WidgetbookState(
    queryParams: {},
    addons: [addon],
    appBuilder: materialAppBuilder,
    directories: [],
    catalog: WidgetbookCatalog.fromDirectories([]),
  );

  await tester.pumpWidget(
    MaterialApp(
      home: WidgetbookScope(
        state: state,
        child: Scaffold(
          body: Builder(
            builder: addon.buildFields,
          ),
        ),
      ),
    ),
  );

  await act?.call();
  await tester.pumpAndSettle();

  final groupMap = FieldCodec.decodeQueryGroup(
    state.queryParams[addon.groupName],
  );

  final setting = addon.valueFromQueryGroup(groupMap);

  expect(setting);
}

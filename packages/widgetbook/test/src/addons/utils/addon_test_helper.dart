import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'extensions/widget_tester_extension.dart';

/// A method that does not wrap the child
Widget buildChild(Widget child) {
  return child;
}

Future<void> testAddon({
  required WidgetTester tester,
  required Widget child,
  required void Function() expect,
  Widget Function(Widget child) build = buildChild,
  Future<void> Function(BuildContext context)? act,
}) async {
  await tester.pumpWidget(build(child));
  final context = tester.findContextByWidget(child);
  await act?.call(context);
  await tester.pumpAndSettle();
  expect();
}

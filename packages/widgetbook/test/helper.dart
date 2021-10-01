import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension WidgetTesterExtension on WidgetTester {
  Future<void> pumpWidgetWithMaterialApp(Widget widget) async {
    return this.pumpWidget(
      MaterialApp(
        home: widget,
      ),
    );
  }

  Future<T> invokeAndPumpProvider<T>(VoidCallback function) async {
    function();
    await this.pump();
    return getProvider<T>(this);
  }
}

T getProvider<T>(WidgetTester tester) {
  var providerFinder = find.byType(T);
  return tester.firstWidget(providerFinder) as T;
}

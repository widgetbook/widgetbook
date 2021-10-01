import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension Something on WidgetTester {
  Future<void> pumpWidgetWithMaterialApp(Widget widget) async {
    return this.pumpWidget(
      MaterialApp(
        home: widget,
      ),
    );
  }
}

T getProvider<T>(WidgetTester tester) {
  var providerFinder = find.byType(T);
  return tester.firstWidget(providerFinder) as T;
}

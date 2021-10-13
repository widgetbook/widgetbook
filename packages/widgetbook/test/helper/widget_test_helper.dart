import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension WidgetTesterExtension on WidgetTester {
  Future<void> pumpWidgetWithMaterialApp(
    Widget widget,
  ) async {
    return pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: widget,
        ),
      ),
    );
  }
}

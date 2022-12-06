import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension WidgetTesterExtension on WidgetTester {
  Future<void> pumpWidgetWithMaterial({
    required Widget child,
  }) {
    return pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: child,
        ),
      ),
    );
  }
}

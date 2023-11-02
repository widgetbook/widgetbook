import 'package:accessibility_tools/accessibility_tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/mocks.dart';

void main() {
  group(
    '$AccessibilityAddon',
    () {
      final addon = AccessibilityAddon();

      test(
        '[buildUseCase] returns [$AccessibilityTools] widget',
        () {
          final widget = addon.buildUseCase(
            MockBuildContext(),
            const Text('child'),
            null,
          );

          expect(
            widget,
            isA<AccessibilityTools>(),
          );
        },
      );
    },
  );
}

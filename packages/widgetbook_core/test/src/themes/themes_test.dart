import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

void main() {
  group(
    '$Themes',
    () {
      test(
        '.dark',
        () {
          expect(
            Themes.dark.colorScheme.primary,
            equals(
              const Color(0xFFA1C9FF),
            ),
          );
        },
      );

      test(
        '.light',
        () {
          expect(
            Themes.light.colorScheme.primary,
            equals(
              const Color(0xFF0060A7),
            ),
          );
        },
      );
    },
  );
}

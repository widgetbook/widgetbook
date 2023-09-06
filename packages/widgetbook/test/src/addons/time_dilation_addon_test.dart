import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

void main() {
  group(
    '$TimeDilationAddon',
    () {
      final value = TimeDilationAddon.values.last;
      final addon = TimeDilationAddon();

      test(
        'given a query group, '
        'then [valueFromQueryGroup] can parse the value',
        () {
          final result = addon.valueFromQueryGroup({
            'value': value.toStringAsFixed(2),
          });

          expect(result, equals(value));
        },
      );

      test(
        'given a [$value] setting, '
        'then [buildUseCase] changes scheduler time dilation',
        () {
          addon.buildUseCase(MockBuildContext(), const Text('child'), value);

          expect(timeDilation, equals(value));

          // Reset
          timeDilation = 1.0;
        },
      );
    },
  );
}

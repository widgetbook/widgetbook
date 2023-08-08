import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/tester_extension.dart';

void main() {
  group(
    '$AlignmentAddon',
    () {
      final addon = AlignmentAddon();

      test(
        'given a query group, '
        'then [valueFromQueryGroup] can parse the value',
        () {
          AlignmentAddon.alignments.forEach(
            (alignment, name) {
              final result = addon.valueFromQueryGroup({
                'alignment': name,
              });

              expect(result, equals(alignment));
            },
          );
        },
      );

      testWidgets(
        'given [Alignment.topLeft] setting, '
        'then [buildUseCase] wraps child with [Align] widget',
        (tester) async {
          await tester.pumpWidgetWithBuilder(
            (context) => addon.buildUseCase(
              context,
              const Text('child'),
              Alignment.topLeft,
            ),
          );

          final alignWidget = tester.widget<Align>(
            find.byType(Align),
          );

          expect(
            alignWidget.alignment,
            equals(Alignment.topLeft),
          );
        },
      );
    },
  );
}

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nested/nested.dart';
import 'package:widgetbook/src/addons/common/common.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

class MockAddon extends WidgetbookAddon<void> {
  MockAddon()
    : super(
        name: 'Mock Addon',
      );

  @override
  List<Field> get fields => [];

  @override
  void valueFromQueryGroup(Map<String, String> group) {}
}

void main() {
  group(
    '$MultiAddonBuilder',
    () {
      testWidgets(
        'returns child widget when addons are empty',
        (tester) async {
          await tester.pumpWidgetWithMaterialApp(
            MultiAddonBuilder(
              addons: [],
              builder: (_, __, ___) => const Text('stub'),
              child: const Text('single child'),
            ),
          );

          final childFinder = find.descendant(
            of: find.byType(MultiAddonBuilder),
            matching: find.byType(Text),
          );

          expect(childFinder, findsOneWidget);
        },
      );

      testWidgets(
        'returns [Nested] widget when addons are available',
        (tester) async {
          await tester.pumpWidgetWithMaterialApp(
            MultiAddonBuilder(
              addons: [MockAddon()],
              builder: (_, __, ___) => const Text('stub'),
              child: const Text('single child'),
            ),
          );

          final nestedFinder = find.descendant(
            of: find.byType(MultiAddonBuilder),
            matching: find.byType(Nested),
          );

          final childFinder = find.descendant(
            of: find.byType(MultiAddonBuilder),
            matching: find.byType(Text),
          );

          expect(nestedFinder, findsOneWidget);
          expect(childFinder, findsOneWidget);
        },
      );
    },
  );
}

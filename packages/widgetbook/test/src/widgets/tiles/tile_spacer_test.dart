import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/widgets/tiles/tile_spacer.dart';

import '../../../helper/widget_test_helper.dart';

void _testLevel(int level, double expectedWidth) {
  testWidgets(
    'has width of $expectedWidth for level $level',
    (WidgetTester tester) async {
      await tester.pumpWidgetWithMaterialApp(
        TileSpacer(
          level: level,
        ),
      );

      final tileSpacerFinder = find.byType(TileSpacer);
      final size = tester.getSize(tileSpacerFinder);

      expect(
        size,
        equals(
          Size(expectedWidth, 0),
        ),
      );
    },
  );
}

void main() {
  group(
    '$TileSpacer',
    () {
      _testLevel(0, 0);
      _testLevel(1, 24);
      _testLevel(2, 48);
    },
  );
}

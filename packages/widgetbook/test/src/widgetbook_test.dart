import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../helper/helper.dart';

void main() {
  group('Widgetbook', () {
    testWidgets(
      'given a header in desktop mode, '
      'then it appears in the NavigationPanel',
      (tester) async {
        tester.view.physicalSize = const Size(1200, 800);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(
          const Widgetbook.material(
            header: Placeholder(),
            directories: [],
          ),
        );

        await tester.pumpAndSettle();

        expect(find.byType(Placeholder), findsOneWidget);

        addTearDown(tester.view.resetPhysicalSize);
      },
    );

    testWidgets(
      'given a header in mobile mode, '
      'when clicking on the bottom navigation bar,'
      'then the header appears in the NavigationPanel',
      (tester) async {
        tester.view.physicalSize = const Size(640, 1200);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(
          const Widgetbook.material(
            header: Placeholder(),
            directories: [],
          ),
        );

        await tester.pumpAndSettle();
        await tester.findAndTap(find.text('Navigation'));

        expect(find.byType(Placeholder), findsOneWidget);

        addTearDown(tester.view.resetPhysicalSize);
      },
    );
  });
}

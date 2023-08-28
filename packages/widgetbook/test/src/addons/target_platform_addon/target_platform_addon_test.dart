import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/addons/target_platform_addon/addon.dart';
import 'package:widgetbook/widgetbook.dart';

import '../utils/addon_test_helper.dart';

void main() {
  final addon = TargetPlatformAddon(
    initialSetting: TargetPlatform.android,
    targetPlatforms: [
      TargetPlatform.android,
      TargetPlatform.iOS,
    ],
  );

  group('$TargetPlatformAddon', () {
    testWidgets(
      'can change target platform',
      (WidgetTester tester) async {
        await testAddon<TargetPlatform>(
          tester: tester,
          addon: addon,
          act: () async {
            final dropdownFinder = find.byType(DropdownMenu<TargetPlatform>);
            await tester.tap(dropdownFinder);
            await tester.pumpAndSettle();

            final textFinder = find.byWidgetPredicate(
              (widget) => widget is Text && widget.data == 'android',
            );
            await tester.tap(textFinder.last);
            await tester.pumpAndSettle();
          },
          expect: (setting) => expect(
            setting,
            equals(TargetPlatform.android),
          ),
        );
      },
    );
  });
}

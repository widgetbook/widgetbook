import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/knobs/knobs.dart';
import 'package:widgetbook/src/repositories/selected_story_repository.dart';
import 'package:widgetbook/src/settings_panel/settings_panel.dart';

import '../../helper/widget_test_helper.dart';

Widget createPanel() {
  final selectedStoryRepository = SelectedStoryRepository();
  final knobsNotifier = KnobsNotifier(selectedStoryRepository);

  final ret = ChangeNotifierProvider(
    create: (context) => knobsNotifier,
    child: Builder(builder: (context) {
      return const SettingsPanel<Theme>();
    }),
  );
  return ret;
}

void main() {
  group(
    '$SettingsPanel',
    () {
      testWidgets(
        'Tabs display',
        (WidgetTester tester) async {
          await tester.pumpWidgetWithMaterialApp(createPanel());
          expect(find.text('Knobs'), findsOneWidget);
        },
      );

      testWidgets(
        'Knobs panel can be selected',
        (WidgetTester tester) async {
          await tester.pumpWidgetWithMaterialApp(createPanel());
          await tester.tap(find.text('Knobs'));
          await tester.pumpAndSettle();
          expect(find.text('No knobs to display'), findsOneWidget);
        },
      );
    },
  );
}

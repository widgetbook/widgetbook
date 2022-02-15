import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/knobs/knobs.dart';
import 'package:widgetbook/src/repositories/selected_story_repository.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/widget_test_helper.dart';

void main() {
  testWidgets(
    'Bool knob added',
    (WidgetTester tester) async {
      final selectedStoryRepository = SelectedStoryRepository();
      final knobsNotifier = KnobsNotifier(selectedStoryRepository);
      final useCase = WidgetbookUseCase(
        name: 'use case',
        builder: (context) {
          return Column(
            children: [
              Text(context.knobs.boolean(
                label: 'label',
                initial: true,
              )
                  ? 'Hi'
                  : 'Bye'),
              ...knobsNotifier.all().map((e) => e.build())
            ],
          );
        },
      );
      selectedStoryRepository.setItem(useCase);
      await tester.pumpWidgetWithMaterialApp(ChangeNotifierProvider(
        create: (context) => knobsNotifier,
        child: Builder(builder: useCase.builder),
      ));
      expect(knobsNotifier.all().length, equals(1));
    },
  );

  testWidgets(
    'Bool knob functions',
    (WidgetTester tester) async {
      final selectedStoryRepository = SelectedStoryRepository();
      final knobsNotifier = KnobsNotifier(selectedStoryRepository);
      final useCase = WidgetbookUseCase(
        name: 'use case',
        builder: (context) {
          return Column(
            children: [
              Text(context.knobs.boolean(
                label: 'label',
                initial: true,
              )
                  ? 'Hi'
                  : 'Bye'),
              ...knobsNotifier.all().map((e) {
                return e.build();
              })
            ],
          );
        },
      );
      selectedStoryRepository.setItem(useCase);
      await tester.pumpWidgetWithMaterialApp(ChangeNotifierProvider(
        create: (context) => knobsNotifier,
        child: Builder(builder: useCase.builder),
      ));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('label-switchTileKnob')));
      await tester.pumpAndSettle();
      expect(find.text('Bye'), findsOneWidget);
    },
  );
}

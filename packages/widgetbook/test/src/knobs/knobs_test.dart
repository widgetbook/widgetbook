import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/knobs/bool_knob.dart';
import 'package:widgetbook/src/repositories/selected_story_repository.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/widget_test_helper.dart';

Widget renderWithKnobs({
  required List<Widget> Function(BuildContext) build,
}) {
  final selectedStoryRepository = SelectedStoryRepository();
  final knobsNotifier = KnobsNotifier(selectedStoryRepository);
  final useCase = WidgetbookUseCase(
    name: 'use case',
    builder: (context) {
      return Column(
        children: [
          ...build(context),
          ...knobsNotifier.all().map(
            (e) {
              return e.build();
            },
          )
        ],
      );
    },
  );
  selectedStoryRepository.setItem(useCase);
  final changeNotifierProvider = ChangeNotifierProvider(
    create: (context) => knobsNotifier,
    child: Builder(builder: useCase.builder),
  );
  return changeNotifierProvider;
}

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
                initialValue: true,
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

      expect(
          knobsNotifier.all(),
          equals(<Knob>[
            BoolKnob(
              label: 'label',
              value: true,
            )
          ]));
    },
  );
}

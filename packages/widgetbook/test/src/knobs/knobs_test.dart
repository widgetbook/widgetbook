import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/knobs/bool_knob.dart';
import 'package:widgetbook/src/knobs/knob.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_core/widgetbook_core.dart' as core;

import '../../helper/widget_test_helper.dart';

Widget renderWithKnobs({
  required List<Widget> Function(BuildContext) build,
}) {
  final knobsNotifier = KnobsNotifier();
  final useCase = WidgetbookUseCaseData(
    path: 'use-case',
    builder: (context) {
      return Column(
        children: [
          ...build(context),
          ...knobsNotifier.all().map(
            (knob) {
              return core.KnobProperty(
                name: knob.label,
                description: knob.description,
                value: knob.value,
                child: Column(
                  children: knob.fields
                      .map(
                        (field) => field.build(context),
                      )
                      .toList(),
                ),
              );
            },
          )
        ],
      );
    },
  );
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
      final knobsNotifier = KnobsNotifier();
      final useCase = WidgetbookUseCaseData(
        path: 'use-case',
        builder: (context) {
          return Column(
            children: [
              Text(
                context.knobs.boolean(
                  label: 'label',
                  initialValue: true,
                )
                    ? 'Hi'
                    : 'Bye',
              ),
              ...knobsNotifier.all().map(
                (knob) {
                  return core.KnobProperty(
                    name: knob.label,
                    description: knob.description,
                    value: knob.value,
                    child: Column(
                      children: knob.fields
                          .map(
                            (field) => field.build(context),
                          )
                          .toList(),
                    ),
                  );
                },
              )
            ],
          );
        },
      );
      await tester.pumpWidgetWithMaterialApp(
        ChangeNotifierProvider(
          create: (context) => knobsNotifier,
          child: Builder(builder: useCase.builder),
        ),
      );
      expect(knobsNotifier.all().length, equals(1));

      expect(
        knobsNotifier.all(),
        equals(<Knob<dynamic>>[
          BoolKnob(
            label: 'label',
            value: true,
          )
        ]),
      );
    },
  );
}

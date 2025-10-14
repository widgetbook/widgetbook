import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

class MockField extends Field<bool> {
  MockField({
    required super.name,
    required super.initialValue,
    required super.defaultValue,
    required super.codec,
  });

  final Fn3Mock<Widget, BuildContext, String, bool?> toWidgetMock = Fn3Mock();

  @override
  Widget toWidget(
    BuildContext context,
    String groupName,
    bool? value,
  ) {
    when(
      () => toWidgetMock.call(context, groupName, value),
    ).thenReturn(Container());

    return toWidgetMock.call(context, groupName, value);
  }
}

void main() {
  setUpAll(() {
    registerFallbackValue(MockBuildContext());
  });

  group(
    '$Field',
    () {
      final field = MockField(
        name: 'mock_field',
        initialValue: true,
        defaultValue: true,
        codec: FieldCodec(
          toParam: (value) => value.toString(),
          toValue: (param) => param == null ? null : param == 'true',
        ),
      );

      test(
        'given a query group with the field name, '
        'when valueFrom is called, '
        'then it returns the decoded field value',
        () {
          const expected = false;
          final result = field.valueFrom({
            field.name: '$expected',
          });

          expect(result, equals(expected));
        },
      );

      test(
        'given a query group without the field name, '
        'when valueFrom is called, '
        'then it returns the initial field value',
        () {
          final result = field.valueFrom({
            'another_field': 'false',
          });

          expect(result, equals(field.initialValue));
        },
      );

      testWidgets(
        'when build is called, '
        'then it calls toWidget with the correct value',
        (tester) async {
          const group = 'mock_group';
          const expected = false;

          await tester.pumpWidgetWithQueryGroups(
            builder: (context) => field.build(context, group),
            queryGroups: {
              group: {'${field.name}': '$expected'},
            },
          );

          verify(
            () => field.toWidgetMock.call(any(), group, expected),
          ).called(1);
        },
      );

      testWidgets(
        'when updateField is called, '
        'then it updates the query params with the new value',
        (tester) async {
          const group = 'mock_group';

          final state = await tester.pumpWidgetWithQueryGroups(
            builder: (context) => Container(),
            queryGroups: {
              group: {field.name: 'false'},
            },
          );

          final context = tester.element(find.byType(Container));

          field.updateField(context, group, true);

          final result = field.valueFrom(state.queryGroups[group]!);

          expect(result, equals(true));
        },
      );

      testWidgets(
        'given a nullable field value, '
        'when updateField is called, '
        'then it updates the query params with the new non nullable value',
        (tester) async {
          const group = 'mock_group';

          final state = await tester.pumpWidgetWithQueryGroups(
            builder: (context) => Container(),
            queryGroups: {
              group: {field.name: '${Field.nullabilitySymbol}false'},
            },
          );

          final context = tester.element(find.byType(Container));

          field.updateField(context, group, true);

          final result = field.valueFrom(state.queryGroups[group]!);

          expect(result, equals(true));
        },
      );
    },
  );
}

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

class MockField extends Field<bool> {
  MockField({
    required super.name,
    required super.type,
    required super.initialValue,
    required super.defaultValue,
    required super.codec,
  });

  final Fn3Mock<Widget, BuildContext, String, bool?> toWidgetMock = Fn3Mock();
  final FnMock<Map<String, dynamic>> toJsonMock = FnMock();

  @override
  Widget toWidget(
    BuildContext context,
    String group,
    bool? value,
  ) {
    when(
      () => toWidgetMock.call(context, group, value),
    ).thenReturn(Container());

    return toWidgetMock.call(context, group, value);
  }

  @override
  Map<String, dynamic> toJson() {
    when(
      () => toJsonMock.call(),
    ).thenReturn({});

    return toJsonMock.call();
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
        type: FieldType.boolean,
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

          await tester.pumpWidgetWithQueryParams(
            queryParams: {group: '{${field.name}:$expected}'},
            builder: (context) => field.build(context, group),
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

          final state = await tester.pumpWidgetWithQueryParams(
            queryParams: {group: '{${field.name}:false}'},
            builder: (context) => Container(),
          );

          final context = tester.element(find.byType(Container));

          field.updateField(context, group, true);

          final result = field.valueFrom(
            FieldCodec.decodeQueryGroup(
              state.queryParams[group],
            ),
          );

          expect(result, equals(true));
        },
      );

      testWidgets(
        'given a nullable field value, '
        'when updateField is called, '
        'then it updates the query params with the new non nullable value',
        (tester) async {
          const group = 'mock_group';

          final state = await tester.pumpWidgetWithQueryParams(
            queryParams: {
              group: '{${field.name}:${Field.nullabilitySymbol}false}',
            },
            builder: (context) => Container(),
          );

          final context = tester.element(find.byType(Container));

          field.updateField(context, group, true);

          final result = field.valueFrom(
            FieldCodec.decodeQueryGroup(state.queryParams[group]),
          );

          expect(result, equals(true));
        },
      );

      test(
        'when toFullJson is called, '
        'then toJson is called',
        () {
          field.toFullJson();

          verify(
            () => field.toJsonMock.call(),
          ).called(1);
        },
      );
    },
  );
}

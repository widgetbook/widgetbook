import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/fields/color_field/hsl_color_text_fields.dart';
import 'package:widgetbook/src/fields/color_field/rgba_color_text_fields.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

void main() {
  group(
    '$ColorField',
    () {
      const blue = Color(0xFF0000FF);
      const blueHex = 'ff0000ff';

      const red = Color(0xFFFF0000);
      const redHex = 'ffff0000';

      final field = ColorField(
        name: 'color_field',
        initialValue: blue,
      );

      test(
        'given a value, '
        'when [codec.toParam] is called, '
        'then it returns the value as a string',
        () {
          final result = field.codec.toParam(red);
          expect(result, equals(redHex));
        },
      );

      test(
        'given a string param, '
        'when [codec.toValue] is called, '
        'then it returns the actual value',
        () {
          final result = field.codec.toValue(redHex);
          expect(result, equals(red));
        },
      );

      testWidgets(
        'given a state that has no field value, '
        'then [toWidget] builds the initial value',
        (tester) async {
          final widget = await tester.pumpField<Color, TextFormField>(
            field,
            null,
          );

          expect(widget.initialValue, equals(blueHex));
        },
      );

      testWidgets(
        'given a state that has a field value, '
        'then [toWidget] builds that value',
        (tester) async {
          final widget = await tester.pumpField<Color, TextFormField>(
            field,
            red,
          );

          expect(widget.initialValue, equals(redHex));
        },
      );

      testWidgets(
          'given a field that has initialColorSpace of [ColorSpace.rgba], '
          'then [toWidget] builds a [RgbaColorTextFields] widget',
          (tester) async {
        final widget = await tester.pumpField<Color, RgbaColorTextFields>(
          ColorField(
            name: 'color_field_rgba',
            initialValue: red,
            initialColorSpace: ColorSpace.rgba,
          ),
          red,
        );

        expect(widget.colorValue, equals(['255', '255', '0', '0']));
      });

      testWidgets(
          'given a field that has initialColorSpace of [ColorSpace.hsl], '
          'then [toWidget] builds a [HslColorTextFields] widget',
          (tester) async {
        final widget = await tester.pumpField<Color, HslColorTextFields>(
          ColorField(
            name: 'color_field_hsl',
            initialValue: red,
            initialColorSpace: ColorSpace.hsl,
          ),
          red,
        );

        expect(widget.colorValue, equals(['0', '100', '50']));
      });

      testWidgets(
          'given a field that has initialColorSpace of [ColorSpace.hsl], '
          'when the [ColorSpace] is changed to [ColorSpace.rgba], '
          'then [toWidget] builds a [RgbaColorTextFields] widget',
          (tester) async {
        final widget = await tester.pumpField<Color, HslColorTextFields>(
          ColorField(
            name: 'color_field_hsl',
            initialValue: red,
            initialColorSpace: ColorSpace.hsl,
          ),
          red,
        );
        expect(widget.colorValue, equals(['0', '100', '50']));

        await tester
            .findAndTap(find.byType(DropdownButtonFormField<ColorSpace>));
        await tester.findAndTap(find.text('rgba'));
        await tester.pumpAndSettle();

        expect(find.byType(RgbaColorTextFields), findsOneWidget);
        expect(find.text('255'), findsNWidgets(2));
      });

      testWidgets(
          'given a field that has initialColorSpace of [ColorSpace.rgba], '
          'when the [ColorSpace] is changed to [ColorSpace.hex], '
          'then [toWidget] builds a [ColorTextField] widget', (tester) async {
        final widget = await tester.pumpField<Color, RgbaColorTextFields>(
          ColorField(
            name: 'color_field',
            initialValue: red,
            initialColorSpace: ColorSpace.rgba,
          ),
          red,
        );
        expect(widget.colorValue, equals(['255', '255', '0', '0']));

        await tester
            .findAndTap(find.byType(DropdownButtonFormField<ColorSpace>));
        await tester.findAndTap(find.text('hex'));
        await tester.pumpAndSettle();

        expect(find.byType(TextFormField), findsOneWidget);
        expect(find.text('ffff0000'), findsOneWidget);
      });
    },
  );
}

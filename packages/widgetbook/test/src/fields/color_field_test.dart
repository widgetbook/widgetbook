import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/fields/color_field/color_picker.dart';
import 'package:widgetbook/src/fields/color_field/hsl_color_text_fields.dart';
import 'package:widgetbook/src/fields/color_field/number_text_field.dart';
import 'package:widgetbook/src/fields/color_field/rgb_color_picker.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

void main() {
  group(
    '$ColorField',
    () {
      const blue = Color(0xFF0000FF);

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
          final widget = await tester.pumpField<Color, ColorPicker>(
            field,
            null,
          );

          expect(widget.value, equals(blue));
        },
      );

      testWidgets(
        'given a state that has a field value, '
        'then [toWidget] builds that value',
        (tester) async {
          final widget = await tester.pumpField<Color, ColorPicker>(
            field,
            red,
          );

          expect(widget.value, equals(red));
        },
      );

      testWidgets(
          'given a field that has initialColorSpace of [ColorSpace.rgb], '
          'then [toWidget] builds a [RgbColorPicker] widget', (tester) async {
        final widget = await tester.pumpField<Color, RgbColorPicker>(
          ColorField(
            name: 'color_field_rgba',
            initialValue: red,
            initialColorSpace: ColorSpace.rgb,
          ),
          red,
        );

        expect(widget.value, red);

        expect(find.byType(NumberTextField), findsAtLeastNWidgets(3));
      });

      testWidgets(
          'given a field that has initialColorSpace of [ColorSpace.hsl], '
          'then [toWidget] builds a [HslColorPicker] widget', (tester) async {
        final widget = await tester.pumpField<Color, HslColorPicker>(
          ColorField(
            name: 'color_field_hsl',
            initialValue: red,
            initialColorSpace: ColorSpace.hsl,
          ),
          red,
        );

        expect(widget.value, red);

        expect(find.byType(NumberTextField), findsAtLeastNWidgets(3));
      });

      testWidgets(
          'given a field that has initialColorSpace of [ColorSpace.hsl], '
          'when the [ColorSpace] is changed to [ColorSpace.rgb], '
          'then [toWidget] builds a [RgbColorPicker] widget', (tester) async {
        final widget = await tester.pumpField<Color, HslColorPicker>(
          ColorField(
            name: 'color_field_hsl',
            initialValue: red,
            initialColorSpace: ColorSpace.hsl,
          ),
          red,
        );
        expect(widget.value, red);

        await tester
            .findAndTap(find.byType(DropdownButtonFormField<ColorSpace>));
        await tester.findAndTap(find.text('rgb'));
        await tester.pumpAndSettle();

        expect(find.byType(RgbColorPicker), findsOneWidget);
        expect(find.text('255'), findsNWidgets(1));
      });

      testWidgets(
          'given a field that has initialColorSpace of [ColorSpace.rgb], '
          'when the [ColorSpace] is changed to [ColorSpace.hex], '
          'then [toWidget] builds a [TextFormField] widget', (tester) async {
        final widget = await tester.pumpField<Color, RgbColorPicker>(
          ColorField(
            name: 'color_field',
            initialValue: red,
            initialColorSpace: ColorSpace.rgb,
          ),
          red,
        );
        expect(widget.value, red);

        await tester
            .findAndTap(find.byType(DropdownButtonFormField<ColorSpace>));
        await tester.findAndTap(find.text('hex'));
        await tester.pumpAndSettle();

        expect(find.byType(TextFormField), findsNWidgets(2));
        expect(find.text('ff0000'), findsOneWidget);
      });
    },
  );
}

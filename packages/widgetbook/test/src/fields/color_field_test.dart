import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/fields/color_field/color_picker.dart';
import 'package:widgetbook/src/fields/color_field/color_picker_dialog.dart';
import 'package:widgetbook/src/fields/color_field/hex_color_picker.dart';
import 'package:widgetbook/src/fields/color_field/hsl_color_picker.dart';
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
        'given a field that has initialColorSpace of [${ColorSpace.hex}], '
        'then [toWidget] builds a [$HexColorPicker] widget',
        (tester) async {
          await tester.pumpField<Color, ColorPicker>(
            ColorField(
              name: 'color_field',
            ),
            red,
          );

          expect(find.byType(HexColorPicker), findsOneWidget);
        },
      );

      testWidgets(
        'given a field that has initialColorSpace of [${ColorSpace.rgb}], '
        'then [toWidget] builds a [$RgbColorPicker] widget',
        (tester) async {
          await tester.pumpField<Color, ColorPicker>(
            ColorField(
              initialColorSpace: ColorSpace.rgb,
              name: 'color_field',
            ),
            red,
          );

          expect(find.byType(RgbColorPicker), findsOneWidget);
        },
      );

      testWidgets(
        'given a field that has initialColorSpace of [${ColorSpace.hsl}], '
        'then [toWidget] builds a [$HslColorPicker] widget',
        (tester) async {
          await tester.pumpField<Color, ColorPicker>(
            ColorField(
              initialColorSpace: ColorSpace.hsl,
              name: 'color_field',
            ),
            red,
          );

          expect(find.byType(HslColorPicker), findsOneWidget);
        },
      );

      testWidgets(
        'given a field that has initialColorSpace of [${ColorSpace.rgb}], '
        'when the [$ColorSpace] is changed to [${ColorSpace.hex}], '
        'then [toWidget] builds a [$HexColorPicker] with same value',
        (tester) async {
          await tester.pumpField<Color, ColorPicker>(
            ColorField(
              name: 'color_field',
              initialValue: red,
            ),
            red,
          );

          await tester.findAndTap(find.byType(DropdownMenu<ColorSpace>));
          await tester.findAndTap(find.text('HEX').last);
          await tester.pumpAndSettle();

          expect(find.byType(HexColorPicker), findsOneWidget);
          expect(find.text('ff0000'), findsOneWidget);
        },
      );

      testWidgets(
        'given a field that has initialColorSpace of [${ColorSpace.hex}], '
        'when the [$ColorSpace] is changed to [${ColorSpace.rgb}], '
        'then [toWidget] builds a [$RgbColorPicker] with same value',
        (tester) async {
          await tester.pumpField<Color, ColorPicker>(
            ColorField(
              name: 'color_field',
              initialValue: red,
            ),
            red,
          );

          await tester.findAndTap(find.byType(DropdownMenu<ColorSpace>));
          await tester.findAndTap(find.text('RGB').last);
          await tester.pumpAndSettle();

          expect(find.byType(RgbColorPicker), findsOneWidget);
          expect(find.text('255'), findsOneWidget);
          expect(find.text('0'), findsNWidgets(2));
        },
      );

      testWidgets(
        'given a field that has initialColorSpace of [${ColorSpace.hex}], '
        'when the [$ColorSpace] is changed to [${ColorSpace.hsl}], '
        'then [toWidget] builds a [$HslColorPicker] with same value',
        (tester) async {
          await tester.pumpField<Color, ColorPicker>(
            ColorField(
              name: 'color_field',
              initialValue: red,
            ),
            red,
          );

          await tester.findAndTap(find.byType(DropdownMenu<ColorSpace>));
          await tester.findAndTap(find.text('HSL').last);
          await tester.pumpAndSettle();

          expect(find.byType(HslColorPicker), findsOneWidget);
          expect(find.text('0'), findsOneWidget);
          expect(find.text('100'), findsNWidgets(2)); // Opacity is 100
          expect(find.text('50'), findsOneWidget);
        },
      );

      testWidgets(
        'given a field, '
        'then [toWidget] builds a [$HexColorPicker] the hintText value',
        (tester) async {
          await tester.pumpField<Color, ColorPicker>(
            field,
            null,
          );

          await tester.findAndTap(find.byType(DropdownMenu<ColorSpace>));
          await tester.findAndTap(find.text('HEX').last);
          await tester.pumpAndSettle();

          final widget = tester.widget<TextField>(
            find.descendant(
              of: find.byType(HexColorPicker),
              matching: find.byType(TextField),
            ),
          );

          expect(widget.decoration?.hintText, equals('Enter a hex color'));
        },
      );

      testWidgets(
        'when user click on color picker square icon, '
        'then [ColorPickerDialog] is displayed',
        (tester) async {
          await tester.pumpField<Color, ColorPicker>(
            field,
            null,
          );

          expect(find.byType(ColorPickerDialog), findsNothing);
          await tester.findAndTap(find.byIcon(Icons.square));
          await tester.pumpAndSettle();

          expect(find.byType(ColorPickerDialog), findsOneWidget);
        },
      );
    },
  );
}

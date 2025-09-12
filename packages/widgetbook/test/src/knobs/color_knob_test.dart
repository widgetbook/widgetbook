import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/fields/color_field/color_field.dart';
import 'package:widgetbook/src/fields/color_field/hex_color_picker.dart';
import 'package:widgetbook/src/fields/color_field/hsl_color_picker.dart';
import 'package:widgetbook/src/fields/color_field/number_text_field.dart';
import 'package:widgetbook/src/fields/color_field/rgb_color_picker.dart';
import 'package:widgetbook/src/knobs/knobs.dart';

import '../../helper/helper.dart';

void main() {
  group(
    '$ColorKnob',
    () {
      testWidgets(
        'given no initial value, '
        'when field is updated, '
        'then the value should be updated',
        (tester) async {
          const key = Key('testContainer');

          await tester.pumpKnob(
            (context) => Container(
              key: key,
              color: context.knobs.colorOrNull(
                label: 'Knob',
              ),
            ),
          );

          expect(tester.widget<Container>(find.byKey(key)).color, isNull);

          await tester.findAndTap(find.byType(Checkbox));
          expect(tester.widget<Container>(find.byKey(key)).color, Colors.white);

          await tester.findAndTap(find.byType(Checkbox));
          expect(tester.widget<Container>(find.byKey(key)).color, isNull);
        },
      );

      testWidgets(
        'given the $ColorSpace is hex, '
        'when the field is updated, '
        'then the value should be updated',
        (tester) async {
          const blue = Color(0xFF0000FF);
          const red = Color(0xFFFF0000);

          await tester.pumpKnob(
            (context) => ColoredBox(
              color: context.knobs.color(
                label: 'Knob',
                initialValue: blue,
              ),
            ),
          );

          await tester.findAndEnter(
            find.byType(HexColorPicker).first,
            'FF0000',
          );

          final box = tester.widget<ColoredBox>(find.byType(ColoredBox));

          expect(box.color, equals(red));
        },
      );

      testWidgets(
        'given the $ColorSpace is hex, '
        'when the $ColorSpace is rgb and the red field is updated, '
        'then the value should be updated',
        (tester) async {
          const blue = Color(0xFF0000FF);
          const purple = Color(0xFFFF00FF);

          await tester.pumpKnob(
            (context) => ColoredBox(
              color: context.knobs.color(
                label: 'Knob',
                initialValue: blue,
              ),
            ),
          );

          await tester.findAndTap(find.byType(DropdownMenu<ColorSpace>));
          await tester.findAndTap(find.text('RGB').last);
          await tester.pumpAndSettle();
          final fields = find.descendant(
            of: find.byType(RgbColorPicker),
            matching: find.byType(NumberTextField),
          );

          await tester.findAndEnter(
            fields.first,
            '255',
          );

          final box = tester.widget<ColoredBox>(find.byType(ColoredBox));

          expect(fields, findsAtLeastNWidgets(3));
          expect(box.color, equals(purple));
        },
      );

      testWidgets(
        'given the $ColorSpace is hex, '
        'when the $ColorSpace is rgb and the green field is updated, '
        'then the value should be updated',
        (tester) async {
          const blue = Color(0xFF0000FF);
          const greenBlue = Color(0xFF00FFFF);

          await tester.pumpKnob(
            (context) => ColoredBox(
              color: context.knobs.color(
                label: 'Knob',
                initialValue: blue,
              ),
            ),
          );

          await tester.findAndTap(find.byType(DropdownMenu<ColorSpace>));
          await tester.findAndTap(find.text('RGB').last);
          await tester.pumpAndSettle();

          final fields = find.descendant(
            of: find.byType(RgbColorPicker),
            matching: find.byType(NumberTextField),
          );

          await tester.findAndEnter(
            fields.at(1),
            '255',
          );

          final box = tester.widget<ColoredBox>(find.byType(ColoredBox));

          expect(fields, findsAtLeastNWidgets(3));
          expect(box.color, equals(greenBlue));
        },
      );

      testWidgets(
        'given the $ColorSpace is hex, '
        'when the $ColorSpace is rgb and the blue field is updated, '
        'then the value should be updated',
        (tester) async {
          const blue = Color(0xFF0000FF);
          const darkerBlue = Color(0xFF000088);

          await tester.pumpKnob(
            (context) => ColoredBox(
              color: context.knobs.color(
                label: 'Knob',
                initialValue: blue,
              ),
            ),
          );

          await tester.findAndTap(find.byType(DropdownMenu<ColorSpace>));
          await tester.findAndTap(find.text('RGB').last);
          await tester.pumpAndSettle();
          final fields = find.descendant(
            of: find.byType(RgbColorPicker),
            matching: find.byType(NumberTextField),
          );

          await tester.findAndEnter(
            fields.at(2),
            '136',
          );

          final box = tester.widget<ColoredBox>(find.byType(ColoredBox));

          expect(fields, findsAtLeastNWidgets(3));
          expect(box.color, equals(darkerBlue));
        },
      );

      testWidgets(
        'given the $ColorSpace is hex, '
        'when the $ColorSpace is rgb and the alpha field is updated, '
        'then the value should be updated',
        (tester) async {
          const blue = Color(0xFF0000FF);
          const transparent = Color(0x000000FF);

          await tester.pumpKnob(
            (context) => ColoredBox(
              color: context.knobs.color(
                label: 'Knob',
                initialValue: blue,
              ),
            ),
          );

          await tester.findAndTap(find.byType(DropdownMenu<ColorSpace>));
          await tester.findAndTap(find.text('RGB').last);
          await tester.pumpAndSettle();

          final opacityField = find.text('100');
          await tester.findAndEnter(opacityField, '0');

          final box = tester.widget<ColoredBox>(find.byType(ColoredBox));

          expect(box.color, equals(transparent));
        },
      );

      testWidgets(
        'given the ColorSpace is hex, '
        'when the ColorSpace is hsl and the hue field is updated, '
        'then the value should be updated',
        (tester) async {
          const blue = Color(0xFF0000FF);
          const magenta = Color(0xFFFF00FF);

          await tester.pumpKnob(
            (context) => ColoredBox(
              color: context.knobs.color(
                label: 'Knob',
                initialValue: blue,
              ),
            ),
          );

          await tester.findAndTap(find.byType(DropdownMenu<ColorSpace>));
          await tester.findAndTap(find.text('HSL').last);
          await tester.pumpAndSettle();
          final fields = find.descendant(
            of: find.byType(HslColorPicker),
            matching: find.byType(NumberTextField),
          );

          await tester.findAndEnter(
            fields.at(0),
            '300',
          );

          final box = tester.widget<ColoredBox>(find.byType(ColoredBox));

          expect(fields, findsAtLeastNWidgets(3));
          expect(box.color, equals(magenta));
        },
      );

      testWidgets(
        'given the $ColorSpace is hex, '
        'when the $ColorSpace is hsl '
        'and the color is white'
        'and the hue field is updated, '
        'and the lightness is 100%, '
        'then the value should be updated anyway',
        (tester) async {
          const white = Color(0xFFFFFFFF);
          const blue = Color(0xFF0000FF);

          await tester.pumpKnob(
            (context) => ColoredBox(
              color: context.knobs.color(
                label: 'Knob',
              ),
            ),
          );

          await tester.findAndTap(find.byType(DropdownMenu<ColorSpace>));
          await tester.findAndTap(find.text('HSL').last);
          await tester.pumpAndSettle();

          final fields = find.descendant(
            of: find.byType(HslColorPicker),
            matching: find.byType(NumberTextField),
          );
          expect(
            fields,
            findsAtLeastNWidgets(3),
          );
          await tester.findAndEnter(
            fields.at(0),
            '240',
          );
          await tester.pumpAndSettle();

          var box = tester.widget<ColoredBox>(find.byType(ColoredBox));

          expect(box.color, equals(white));
          await tester.findAndEnter(
            fields.at(1),
            '100',
          );
          await tester.findAndEnter(
            fields.at(2),
            '50',
          );

          box = tester.widget<ColoredBox>(find.byType(ColoredBox));

          expect(box.color, equals(blue));
        },
      );

      testWidgets(
        'given the $ColorSpace is hex, '
        'when the $ColorSpace is hsl and the saturation field is updated, '
        'then the value should be updated',
        (tester) async {
          const blue = Color(0xFF0000FF);
          const unsaturatedBlue = Color(0xFF4040BF);

          await tester.pumpKnob(
            (context) => ColoredBox(
              color: context.knobs.color(
                label: 'Knob',
                initialValue: blue,
              ),
            ),
          );

          await tester.findAndTap(find.byType(DropdownMenu<ColorSpace>));
          await tester.findAndTap(find.text('HSL').last);
          await tester.pumpAndSettle();

          final fields = find.descendant(
            of: find.byType(HslColorPicker),
            matching: find.byType(NumberTextField),
          );
          await tester.findAndEnter(
            fields.at(1),
            '50',
          );

          final box = tester.widget<ColoredBox>(find.byType(ColoredBox));

          expect(fields, findsAtLeastNWidgets(3));
          expect(box.color, equals(unsaturatedBlue));
        },
      );

      testWidgets(
        'given the $ColorSpace is hex, '
        'when the $ColorSpace is hsl and the lightness field is updated, '
        'then the value should be updated',
        (tester) async {
          const blue = Color(0xFF0000FF);
          const lightBlue = Color(0xFF8080ff);

          await tester.pumpKnob(
            (context) => ColoredBox(
              color: context.knobs.color(
                label: 'Knob',
                initialValue: blue,
              ),
            ),
          );

          await tester.findAndTap(find.byType(DropdownMenu<ColorSpace>));
          await tester.findAndTap(find.text('HSL').last);
          await tester.pumpAndSettle();

          final fields = find.descendant(
            of: find.byType(HslColorPicker),
            matching: find.byType(NumberTextField),
          );
          await tester.findAndEnter(
            fields.at(2),
            '75',
          );

          final box = tester.widget<ColoredBox>(find.byType(ColoredBox));

          expect(fields, findsAtLeastNWidgets(3));
          expect(box.color, equals(lightBlue));
        },
      );
    },
  );
}

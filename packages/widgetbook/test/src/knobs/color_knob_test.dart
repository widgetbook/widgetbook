import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/fields/color_field.dart';
import 'package:widgetbook/src/knobs/knobs.dart';

import '../../helper/helper.dart';

void main() {
  group(
    '$ColorKnob',
    () {
      testWidgets(
        'given the ColorSpace is hex, '
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
            find.byType(TextField),
            'FFFF0000',
          );

          final box = tester.widget<ColoredBox>(find.byType(ColoredBox));

          expect(box.color, equals(red));
        },
      );

      testWidgets(
        'given the ColorSpace is hex, '
        'when the ColorSpace is rgba and the red field is updated, '
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

          await tester
              .findAndTap(find.byType(DropdownButtonFormField<ColorSpace>));
          await tester.findAndTap(find.text('rgba'));
          await tester.pumpAndSettle();

          await tester.findAndEnter(
            find.byType(TextField).first,
            '255',
          );

          final box = tester.widget<ColoredBox>(find.byType(ColoredBox));

          expect(box.color, equals(purple));
        },
      );

      testWidgets(
        'given the ColorSpace is hex, '
        'when the ColorSpace is rgba and the green field is updated, '
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

          await tester
              .findAndTap(find.byType(DropdownButtonFormField<ColorSpace>));
          await tester.findAndTap(find.text('rgba'));
          await tester.pumpAndSettle();
          final textFields = find.byType(TextField);
          expect(textFields, findsNWidgets(4));
          await tester.findAndEnter(
            textFields.at(1),
            '255',
          );

          final box = tester.widget<ColoredBox>(find.byType(ColoredBox));

          expect(box.color, equals(greenBlue));
        },
      );

      testWidgets(
        'given the ColorSpace is hex, '
        'when the ColorSpace is rgba and the blue field is updated, '
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

          await tester
              .findAndTap(find.byType(DropdownButtonFormField<ColorSpace>));
          await tester.findAndTap(find.text('rgba'));
          await tester.pumpAndSettle();
          final textFields = find.byType(TextField);
          expect(textFields, findsNWidgets(4));
          await tester.findAndEnter(
            textFields.at(2),
            '136',
          );

          final box = tester.widget<ColoredBox>(find.byType(ColoredBox));

          expect(box.color, equals(darkerBlue));
        },
      );

      testWidgets(
        'given the ColorSpace is hex, '
        'when the ColorSpace is rgba and the alpha field is updated, '
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

          await tester
              .findAndTap(find.byType(DropdownButtonFormField<ColorSpace>));
          await tester.findAndTap(find.text('rgba'));
          await tester.pumpAndSettle();
          final textFields = find.byType(TextField);
          expect(textFields, findsNWidgets(4));
          await tester.findAndEnter(
            textFields.last,
            '0',
          );

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

          await tester
              .findAndTap(find.byType(DropdownButtonFormField<ColorSpace>));
          await tester.findAndTap(find.text('hsl'));
          await tester.pumpAndSettle();

          final textFields = find.byType(TextField);
          expect(textFields, findsNWidgets(3));
          await tester.findAndEnter(
            textFields.at(0),
            '300',
          );

          final box = tester.widget<ColoredBox>(find.byType(ColoredBox));

          expect(box.color, equals(magenta));
        },
      );

      testWidgets(
        'given the ColorSpace is hex, '
        'when the ColorSpace is hsl '
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
                initialValue: white,
              ),
            ),
          );

          await tester
              .findAndTap(find.byType(DropdownButtonFormField<ColorSpace>));
          await tester.findAndTap(find.text('hsl'));
          await tester.pumpAndSettle();

          final textFields = find.byType(TextField);
          expect(textFields, findsNWidgets(3));
          await tester.findAndEnter(
            textFields.at(0),
            '240',
          );
          await tester.pumpAndSettle();

          var box = tester.widget<ColoredBox>(find.byType(ColoredBox));

          expect(box.color, equals(white));
          await tester.findAndEnter(
            textFields.at(1),
            '100',
          );
          await tester.findAndEnter(
            textFields.at(2),
            '50',
          );

          box = tester.widget<ColoredBox>(find.byType(ColoredBox));

          expect(box.color, equals(blue));
        },
      );

      testWidgets(
        'given the ColorSpace is hex, '
        'when the ColorSpace is hsl and the saturation field is updated, '
        'then the value should be updated',
        (tester) async {
          const blue = Color(0xFF0000FF);
          const desaturatedBlue = Color(0xFF4040C0);

          await tester.pumpKnob(
            (context) => ColoredBox(
              color: context.knobs.color(
                label: 'Knob',
                initialValue: blue,
              ),
            ),
          );

          await tester
              .findAndTap(find.byType(DropdownButtonFormField<ColorSpace>));
          await tester.findAndTap(find.text('hsl'));
          await tester.pumpAndSettle();

          final textFields = find.byType(TextFormField);
          expect(textFields, findsNWidgets(3));
          await tester.findAndEnter(
            textFields.at(1),
            '50',
          );

          final box = tester.widget<ColoredBox>(find.byType(ColoredBox));

          expect(box.color, equals(desaturatedBlue));
        },
      );

      testWidgets(
        'given the ColorSpace is hex, '
        'when the ColorSpace is hsl and the lightness field is updated, '
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

          await tester
              .findAndTap(find.byType(DropdownButtonFormField<ColorSpace>));
          await tester.findAndTap(find.text('hsl'));
          await tester.pumpAndSettle();

          final textFields = find.byType(TextField);
          expect(textFields, findsNWidgets(3));
          await tester.findAndEnter(
            textFields.at(2),
            '75',
          );

          final box = tester.widget<ColoredBox>(find.byType(ColoredBox));

          expect(box.color, equals(lightBlue));
        },
      );

      testWidgets(
        'given the Color Picker is opened, '
        'when I click on the Color Picker button, '
        'then the Color Picker should close',
        (tester) async {
          const blue = Color(0xFF0000FF);

          await tester.pumpKnob(
            (context) => ColoredBox(
              color: context.knobs.color(
                label: 'Knob',
                initialValue: blue,
              ),
            ),
          );

          await tester.findAndTap(find.byType(IconButton));
          await tester.pumpAndSettle();

          expect(find.byType(GridView), findsOneWidget);
          expect(find.byType(InkWell), findsAtLeastNWidgets(16));

          await tester.findAndTap(find.byType(IconButton));
          await tester.pumpAndSettle();

          expect(find.byType(GridView), findsNothing);
        },
      );

      testWidgets(
        'given the Color Picker is closed, '
        'when I click on the Color Picker button, '
        'and the Color Picker is opened, '
        'and I click on one of the colors, '
        'then the value should be updated',
        (tester) async {
          const blue = Color(0xFF0000FF);

          await tester.pumpKnob(
            (context) => ColoredBox(
              color: context.knobs.color(
                label: 'Knob',
                initialValue: blue,
              ),
            ),
          );

          await tester.findAndTap(find.byType(IconButton));
          await tester.pumpAndSettle();

          expect(find.byType(GridView), findsOneWidget);
          expect(find.byType(InkWell), findsAtLeastNWidgets(16));

          await tester.findAndTap(
            find.byKey(const Key('colorPickerItem0')),
          );
          await tester.pumpAndSettle();

          final box = tester.widget<ColoredBox>(find.byType(ColoredBox).first);

          expect(box.color, equals(Colors.primaries[0].shade500));
        },
      );
    },
  );
}

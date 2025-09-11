import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/knobs/knobs.dart';

void main() {
  group('$KnobsRegistry', () {
    test('when register is called again for a knob, '
        'then it well update it', () {
      final label = 'Object Dropdown Knob';
      final registry = KnobsRegistry(onLock: () {});
      final knob_1 = ObjectDropdownKnob(
        label: label,
        initialValue: null,
        options: ['test_1', 'test_2'],
      );
      final knob_2 = ObjectDropdownKnob(
        label: label,
        initialValue: true,
        options: ['test_1', 'test_2', 'test_3'],
      );

      registry.register(knob_1, {});
      registry.register(knob_2, {});

      final knob = registry[knob_1.label] as ObjectDropdownKnob;
      expect(knob, equals(knob_2));
      expect(knob.label, equals(knob_2.label));
      expect(knob.initialValue, equals(knob_2.initialValue));
      expect(knob.options, equals(knob_2.options));
    });
  });
}

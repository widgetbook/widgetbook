import 'package:flutter/widgets.dart';

import '../state/state.dart';
import 'bool_knob.dart';
import 'color_knob.dart';
import 'knob.dart';
import 'number_knob.dart';
import 'options_knob.dart';
import 'slider_knob.dart';
import 'text_knob.dart';

extension Knobs on BuildContext {
  /// Creates adjustable parameters for the WidgetbookUseCase
  KnobsBuilder get knobs {
    final state = WidgetbookState.of(this);

    return KnobsBuilder(
      onKnobAdded: state.registerKnob,
    );
  }
}

class KnobsBuilder {
  const KnobsBuilder({
    required this.onKnobAdded,
  });

  final T? Function<T>(Knob<T> knob) onKnobAdded;

  /// Creates a checkbox that can be toggled on and off
  bool boolean({
    required String label,
    String? description,
    bool initialValue = false,
  }) {
    return onKnobAdded(
      BoolKnob(
        label: label,
        description: description,
        value: initialValue,
      ),
    )!;
  }

  /// Creates a checkbox that can be toggled on and off and optionally hold a
  /// null value
  bool? nullableBoolean({
    required String label,
    String? description,
    bool? initialValue = false,
  }) {
    return onKnobAdded<bool?>(
      NullableBoolKnob(
        label: label,
        description: description,
        value: initialValue,
      ),
    );
  }

  /// Creates a textfield that can be typed in and optionally hold a
  /// color value
  Color color({
    required String label,
    required Color initialValue,
    String? description,
  }) {
    return onKnobAdded(
      ColorKnob(
        label: label,
        value: initialValue,
      ),
    )!;
  }

  /// Creates a textfield that can be typed in
  String text({
    required String label,
    String? description,
    String initialValue = '',
    int? maxLines = 1,
  }) {
    return onKnobAdded(
      TextKnob(
        label: label,
        value: initialValue,
        description: description,
        maxLines: maxLines,
      ),
    )!;
  }

  /// Creates a textfield that can be typed in and optionally hold a
  /// null value
  String? nullableText({
    required String label,
    String? description,
    String? initialValue,
    int? maxLines = 1,
  }) {
    return onKnobAdded<String?>(
      NullableTextKnob(
        label: label,
        value: initialValue,
        description: description,
        maxLines: maxLines,
      ),
    );
  }

  /// Creates a slider that can be slid to specific double values. You can use
  /// the `num.toInt()` function to make this into an integer
  double slider({
    required String label,
    String? description,
    double? initialValue,
    double? max,
    double? min,
    int? divisions,
  }) {
    initialValue ??= max ?? min ?? 10;
    return onKnobAdded(
      SliderKnob(
        label: label,
        value: initialValue,
        description: description,
        min: min ?? initialValue - 10,
        max: max ?? initialValue + 10,
        divisions: divisions,
      ),
    )!;
  }

  /// Creates a slider that can be slid to specific double values. You can use
  /// the `num?.toInt()` function to make this into an integer.
  /// Can optionally hold a null value
  double? nullableSlider({
    required String label,
    String? description,
    double? initialValue,
    double? max,
    double? min,
    int? divisions,
  }) {
    initialValue ??= max ?? min ?? 10;
    return onKnobAdded<double?>(
      NullableSliderKnob(
        label: label,
        value: initialValue,
        description: description,
        min: min ?? initialValue - 10,
        max: max ?? initialValue + 10,
        divisions: divisions,
      ),
    );
  }

  /// Creates a textfield which users can type double values into. You can use
  /// the `num?.toInt()` function to turn this into an integer
  num number({
    required String label,
    String? description,
    num initialValue = 0,
  }) {
    return onKnobAdded(
      NumberKnob(
        label: label,
        value: initialValue.toDouble(),
        description: description,
      ),
    )!;
  }

  /// Creates a textfield which users can type double values into. You can use
  /// the `num?.toInt()` function to turn this into an integer
  /// Can optionally hold a null value
  num? nullableNumber({
    required String label,
    String? description,
    num? initialValue,
  }) {
    return onKnobAdded<num?>(
      NullableNumberKnob(
        label: label,
        value: initialValue?.toDouble(),
        description: description,
      ),
    );
  }

  /// Allow the users to select from a list of options in a drop down box.
  /// The initial value is the first item in the list of options
  /// Must contain at least one value
  T options<T>({
    required String label,
    required List<T> options,
    String? description,
    String Function(T)? labelBuilder,
  }) {
    assert(options.isNotEmpty, 'Must specify at least one option');
    return onKnobAdded(
      OptionsKnob(
        label: label,
        value: options.first,
        description: description,
        options: options,
        labelBuilder: labelBuilder,
      ),
    )!;
  }
}

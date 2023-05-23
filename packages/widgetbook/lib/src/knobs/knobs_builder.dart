import 'package:flutter/widgets.dart';

import '../state/state.dart';
import 'boolean_knob.dart';
import 'color_knob.dart';
import 'double_input_knob.dart';
import 'double_slider_knob.dart';
import 'knob.dart';
import 'list_knob.dart';
import 'string_knob.dart';

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
      BooleanKnob(
        label: label,
        description: description,
        value: initialValue,
      ),
    )!;
  }

  /// Creates a checkbox that can be toggled on and off and optionally hold a
  /// null value
  bool? booleanOrNull({
    required String label,
    String? description,
    bool? initialValue = false,
  }) {
    return onKnobAdded<bool?>(
      BooleanOrNullKnob(
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
  String string({
    required String label,
    String? description,
    String initialValue = '',
    int? maxLines = 1,
  }) {
    return onKnobAdded(
      StringKnob(
        label: label,
        value: initialValue,
        description: description,
        maxLines: maxLines,
      ),
    )!;
  }

  /// Creates a textfield that can be typed in and optionally hold a
  /// null value
  String? stringOrNull({
    required String label,
    String? description,
    String? initialValue,
    int? maxLines = 1,
  }) {
    return onKnobAdded<String?>(
      StringOrNullKnob(
        label: label,
        value: initialValue,
        description: description,
        maxLines: maxLines,
      ),
    );
  }

  /// Creates a slider that can be slid to specific double values. You can use
  /// the `num.toInt()` function to make this into an integer
  double doubleSlider({
    required String label,
    String? description,
    double? initialValue,
    double? max,
    double? min,
    int? divisions,
  }) {
    initialValue ??= max ?? min ?? 10;
    return onKnobAdded(
      DoubleSliderKnob(
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
  double? doubleOrNullSlider({
    required String label,
    String? description,
    double? initialValue,
    double? max,
    double? min,
    int? divisions,
  }) {
    initialValue ??= max ?? min ?? 10;
    return onKnobAdded<double?>(
      DoubleOrNullSliderKnob(
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
  double doubleInput({
    required String label,
    String? description,
    double initialValue = 0,
  }) {
    return onKnobAdded(
      DoubleInputKnob(
        label: label,
        value: initialValue,
        description: description,
      ),
    )!;
  }

  /// Creates a textfield which users can type double values into. You can use
  /// the `num?.toInt()` function to turn this into an integer
  /// Can optionally hold a null value
  double? doubleOrNullInput({
    required String label,
    String? description,
    double? initialValue,
  }) {
    return onKnobAdded<double?>(
      DoubleOrNullInputKnob(
        label: label,
        value: initialValue,
        description: description,
      ),
    );
  }

  /// Allow the users to select from a list of options in a drop down box.
  /// The initial value is the first item in the list of options
  /// Must contain at least one value
  T list<T>({
    required String label,
    required List<T> options,
    String? description,
    String Function(T)? labelBuilder,
  }) {
    assert(options.isNotEmpty, 'Must specify at least one option');
    return onKnobAdded(
      ListKnob(
        label: label,
        value: options.first,
        description: description,
        options: options,
        labelBuilder: labelBuilder,
      ),
    )!;
  }
}

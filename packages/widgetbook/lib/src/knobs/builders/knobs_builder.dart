import 'package:flutter/material.dart';

import '../../fields/fields.dart';
import '../boolean_knob.dart';
import '../color_knob.dart';
import '../knob.dart';
import '../list_knob.dart';
import '../string_knob.dart';
import 'double_knobs_builder.dart';

typedef KnobAdded = T? Function<T>(Knob<T?> knob);

class KnobsBuilder {
  KnobsBuilder(
    this.onKnobAdded,
  )   : this.double = DoubleKnobsBuilder(onKnobAdded),
        this.doubleOrNull = DoubleOrNullKnobsBuilder(onKnobAdded);

  final KnobAdded onKnobAdded;
  final DoubleKnobsBuilder double;
  final DoubleOrNullKnobsBuilder doubleOrNull;

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
    return onKnobAdded(
      BooleanKnob.nullable(
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
    ColorSpace initialColorSpace = ColorSpace.hex,
    String? description,
  }) {
    return onKnobAdded(
      ColorKnob(
        label: label,
        value: initialValue,
        initialColorSpace: initialColorSpace,
        description: description,
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
    return onKnobAdded(
      StringKnob.nullable(
        label: label,
        value: initialValue,
        description: description,
        maxLines: maxLines,
      ),
    );
  }

  /// Allow the users to select from a list of options in a drop down box.
  /// Must contain at least one value.
  T list<T>({
    required String label,
    required List<T> options,
    T? initialOption,
    String? description,
    LabelBuilder<T>? labelBuilder,
  }) {
    assert(options.isNotEmpty, 'Must specify at least one option');
    return onKnobAdded(
      ListKnob<T>(
        label: label,
        value: initialOption ?? options.first,
        description: description,
        options: options,
        labelBuilder: labelBuilder,
      ),
    )!;
  }

  /// Allow the users to select from a list of options in a drop down box that
  /// might contain a null value.
  T? listOrNull<T>({
    required String label,
    required List<T?> options,
    T? initialOption,
    String? description,
    LabelBuilder<T?>? labelBuilder,
  }) {
    assert(options.isNotEmpty, 'Must specify at least one option');
    return onKnobAdded(
      ListKnob<T?>.nullable(
        label: label,
        value: initialOption ?? options.first,
        description: description,
        options: options,
        labelBuilder: labelBuilder,
      ),
    );
  }
}

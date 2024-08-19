import 'package:flutter/material.dart';

import '../../fields/fields.dart';
import '../boolean_knob.dart';
import '../color_knob.dart';
import '../date_time_knob.dart';
import '../duration_knob.dart';
import '../knob.dart';
import '../list_knob.dart';
import '../string_knob.dart';
import 'double_knobs_builder.dart';
import 'int_knobs_builder.dart';

typedef KnobAdded = T? Function<T>(Knob<T?> knob);
typedef $int = int;

class KnobsBuilder {
  KnobsBuilder(
    this.onKnobAdded,
  )   : this.double = DoubleKnobsBuilder(onKnobAdded),
        this.doubleOrNull = DoubleOrNullKnobsBuilder(onKnobAdded),
        this.int = IntKnobsBuilder(onKnobAdded),
        this.intOrNull = IntOrNullKnobsBuilder(onKnobAdded);

  final KnobAdded onKnobAdded;
  final DoubleKnobsBuilder double;
  final DoubleOrNullKnobsBuilder doubleOrNull;
  final IntKnobsBuilder int;
  final IntOrNullKnobsBuilder intOrNull;

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
        initialValue: initialValue,
      ),
    )!;
  }

  /// Creates a checkbox that can be toggled on and off and optionally hold a
  /// null value
  bool? booleanOrNull({
    required String label,
    String? description,
    bool? initialValue,
  }) {
    return onKnobAdded(
      BooleanKnob.nullable(
        label: label,
        description: description,
        initialValue: initialValue,
      ),
    );
  }

  /// Creates a color picker that can be used to select a color.
  Color color({
    required String label,
    Color initialValue = Colors.white,
    ColorSpace initialColorSpace = ColorSpace.hex,
    String? description,
  }) {
    return onKnobAdded(
      ColorKnob(
        label: label,
        initialValue: initialValue,
        initialColorSpace: initialColorSpace,
        description: description,
      ),
    )!;
  }

  /// Creates a color picker that can be used to select a color.
  Color? colorOrNull({
    required String label,
    Color? initialValue,
    ColorSpace initialColorSpace = ColorSpace.hex,
    String? description,
  }) {
    return onKnobAdded(
      ColorKnob.nullable(
        label: label,
        initialValue: initialValue,
        initialColorSpace: initialColorSpace,
        description: description,
      ),
    );
  }

  /// Creates a textfield that can be typed in
  String string({
    required String label,
    String? description,
    String initialValue = '',
    $int? maxLines = 1,
  }) {
    return onKnobAdded(
      StringKnob(
        label: label,
        initialValue: initialValue,
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
    $int? maxLines = 1,
  }) {
    return onKnobAdded(
      StringKnob.nullable(
        label: label,
        initialValue: initialValue,
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
        initialValue: initialOption ?? options.first,
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
    return onKnobAdded(
      ListKnob<T?>.nullable(
        label: label,
        initialValue: initialOption,
        description: description,
        options: options,
        labelBuilder: labelBuilder,
      ),
    );
  }

  /// Creates a duration input that can be typed in
  Duration duration({
    required String label,
    Duration initialValue = Duration.zero,
    String? description,
  }) {
    return onKnobAdded(
      DurationKnob(
        label: label,
        initialValue: initialValue,
        description: description,
      ),
    )!;
  }

  /// Creates a duration input that can be adjusted and optionally hold a
  /// null value
  Duration? durationOrNull({
    required String label,
    Duration? initialValue,
    String? description,
  }) {
    return onKnobAdded(
      DurationKnob.nullable(
        label: label,
        initialValue: initialValue,
        description: description,
      ),
    );
  }

  /// Creates a text field that can be used to select a date and time
  DateTime dateTime({
    required String label,
    required DateTime initialValue,
    String? description,
    required DateTime start,
    required DateTime end,
  }) {
    return onKnobAdded(
      DateTimeKnob(
        label: label,
        initialValue: initialValue,
        description: description,
        start: start,
        end: end,
      ),
    )!;
  }

  /// Creates a text field that can be used to select a date and time and can
  /// be initially empty
  DateTime? dateTimeOrNull({
    required String label,
    DateTime? initialValue,
    String? description,
    required DateTime start,
    required DateTime end,
  }) {
    return onKnobAdded(
      DateTimeKnob.nullable(
        label: label,
        initialValue: initialValue,
        description: description,
        start: start,
        end: end,
      ),
    );
  }
}

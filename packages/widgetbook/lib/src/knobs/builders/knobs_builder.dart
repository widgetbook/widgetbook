import 'package:flutter/material.dart';

import '../../fields/fields.dart';
import '../boolean_knob.dart';
import '../color_knob.dart';
import '../date_time_knob.dart';
import '../duration_knob.dart';
import '../knob.dart';
import '../object_dropdown_knob.dart';
import '../string_knob.dart';
import 'double_knobs_builder.dart';
import 'int_knobs_builder.dart';
import 'iterable_knobs_builder.dart';
import 'object_knobs_builder.dart';

/// @nodoc
typedef $int = int; // Allows us to use `int` as a knob name without conflict.

/// @nodoc
typedef KnobAdded = T? Function<T>(Knob<T?> knob);

/// The builder is used to create and register a variety of knobs that can be
/// used in your use-cases.
///
/// This builder is provided to `context` in the use-case functions.
class KnobsBuilder {
  /// Creates a [KnobsBuilder] with the provided [onKnobAdded] callback.
  KnobsBuilder(
    this.onKnobAdded,
  ) : this.double = DoubleKnobsBuilder(onKnobAdded),
      this.doubleOrNull = DoubleOrNullKnobsBuilder(onKnobAdded),
      this.int = IntKnobsBuilder(onKnobAdded),
      this.intOrNull = IntOrNullKnobsBuilder(onKnobAdded),
      this.object = ObjectKnobsBuilder(onKnobAdded),
      this.objectOrNull = ObjectOrNullKnobsBuilder(onKnobAdded),
      this.iterable = IterableKnobsBuilder(onKnobAdded),
      this.iterableOrNull = IterableOrNullKnobsBuilder(onKnobAdded);

  /// The callback that is used to add a knob.
  /// Used to register the knob in the use-case.
  final KnobAdded onKnobAdded;

  /// A builder for double knobs.
  final DoubleKnobsBuilder double;

  /// A builder for double knobs that can hold a null value.
  final DoubleOrNullKnobsBuilder doubleOrNull;

  /// A builder for integer knobs.
  final IntKnobsBuilder int;

  /// A builder for integer knobs that can hold a null value.
  final IntOrNullKnobsBuilder intOrNull;

  /// A builder for generic iterable knobs.
  final IterableKnobsBuilder iterable;

  /// A builder for generic iterable knobs that can hold a null value.
  final IterableOrNullKnobsBuilder iterableOrNull;

  /// A builder for generic object knobs.
  final ObjectKnobsBuilder object;

  /// A builder for generic object knobs that can hold a null value.
  final ObjectOrNullKnobsBuilder objectOrNull;

  /// A [Knob] that holds a [bool] value.
  /// Learn more: https://docs.widgetbook.io/knobs/boolean
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

  /// A [Knob] that holds a [bool] value and can be null.
  /// Learn more: https://docs.widgetbook.io/knobs/boolean
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

  /// A [Knob] that holds a [Color] value.
  /// Learn more: https://docs.widgetbook.io/knobs/color
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

  /// A [Knob] that holds a [Color] value and can be null.
  /// Learn more: https://docs.widgetbook.io/knobs/color
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

  /// A [Knob] that holds a [String] value.
  /// Learn more: https://docs.widgetbook.io/knobs/string
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

  /// A [Knob] that holds a [String] value and can be null.
  /// Learn more: https://docs.widgetbook.io/knobs/string
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

  /// @nodoc
  @Deprecated('Use `knobs.object.dropdown` instead.')
  T list<T>({
    required String label,
    required List<T> options,
    T? initialOption,
    String? description,
    LabelBuilder<T>? labelBuilder,
  }) {
    assert(options.isNotEmpty, 'Must specify at least one option');
    return onKnobAdded(
      ObjectDropdownKnob<T>(
        label: label,
        initialValue: initialOption ?? options.first,
        description: description,
        options: options,
        labelBuilder: labelBuilder,
      ),
    )!;
  }

  /// @nodoc
  @Deprecated('Use `knobs.objectOrNull.dropdown` instead.')
  T? listOrNull<T>({
    required String label,
    required List<T?> options,
    T? initialOption,
    String? description,
    LabelBuilder<T?>? labelBuilder,
  }) {
    return onKnobAdded(
      ObjectDropdownKnob<T?>.nullable(
        label: label,
        initialValue: initialOption,
        description: description,
        options: options,
        labelBuilder: labelBuilder,
      ),
    );
  }

  /// A [Knob] that holds a [Duration] value.
  /// Learn more: https://docs.widgetbook.io/knobs/duration
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

  /// A [Knob] that holds a [Duration] value and can be null.
  /// Learn more: https://docs.widgetbook.io/knobs/duration
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

  /// A [Knob] that holds a [DateTime] value.
  /// Learn more: https://docs.widgetbook.io/knobs/datetime
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

  /// A [Knob] that holds a [DateTime] value and can be null.
  /// Learn more: https://docs.widgetbook.io/knobs/datetime
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

import '../../fields/object_dropdown_field.dart';
import '../knob.dart';
import '../object_dropdown_knob.dart';
import '../object_segmented_knob.dart';
import 'knobs_builder.dart';

/// A [KnobsBuilder] for object knobs.
class ObjectKnobsBuilder {
  /// Creates a [ObjectKnobsBuilder] with the provided [onKnobAdded] callback.
  ObjectKnobsBuilder(this.onKnobAdded);

  /// The callback that is used to add a knob.
  final KnobAdded onKnobAdded;

  /// A [Knob] that holds an [T] value with a segmented control.
  /// Learn more: https://docs.widgetbook.io/knobs/object/segmented
  T segmented<T>({
    required String label,
    required List<T> options,
    T? initialOption,
    String? description,
    LabelBuilder<T>? labelBuilder,
  }) {
    assert(options.isNotEmpty, 'Must specify at least one option');
    return onKnobAdded(
      ObjectSegmentedKnob<T>(
        label: label,
        initialValue: initialOption ?? options.first,
        description: description,
        options: options,
        labelBuilder: labelBuilder,
      ),
    )!;
  }

  /// A [Knob] that holds an [T] value with a dropdown menu.
  /// Learn more: https://docs.widgetbook.io/knobs/object/dropdown
  T dropdown<T>({
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
        options: options,
        description: description,
        labelBuilder: labelBuilder,
      ),
    )!;
  }
}

/// Same as [ObjectKnobsBuilder] but allows the knob to hold a null value.
class ObjectOrNullKnobsBuilder {
  /// Creates a [ObjectOrNullKnobsBuilder] with the provided [onKnobAdded] callback.
  ObjectOrNullKnobsBuilder(
    KnobAdded onKnobAdded,
  ) : this.onKnobAdded = onKnobAdded;

  /// The callback that is used to add a knob.
  final KnobAdded onKnobAdded;

  /// A [Knob] that holds an [T] value with a segmented control that can be null.
  /// Learn more: https://docs.widgetbook.io/knobs/object/segmented
  T? segmented<T>({
    required String label,
    required List<T> options,
    T? initialOption,
    String? description,
    LabelBuilder<T>? labelBuilder,
  }) {
    assert(options.isNotEmpty, 'Must specify at least one option');
    return onKnobAdded(
      ObjectSegmentedKnob<T>.nullable(
        label: label,
        initialValue: initialOption,
        description: description,
        options: options,
        labelBuilder: labelBuilder,
      ),
    );
  }

  /// A [Knob] that holds an [T] value with a dropdown menu that can be null.
  /// Learn more: https://docs.widgetbook.io/knobs/object/dropdown
  T? dropdown<T>({
    required String label,
    required List<T> options,
    T? initialOption,
    String? description,
    LabelBuilder<T>? labelBuilder,
  }) {
    assert(options.isNotEmpty, 'Must specify at least one option');
    return onKnobAdded(
      ObjectDropdownKnob<T>.nullable(
        label: label,
        initialValue: initialOption,
        options: options,
        description: description,
        labelBuilder: labelBuilder,
      ),
    );
  }
}

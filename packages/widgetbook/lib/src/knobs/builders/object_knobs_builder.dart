import '../../fields/list_field.dart';
import '../knob.dart';
import '../object_segmented_knob.dart';

class ObjectKnobsBuilder {
  const ObjectKnobsBuilder(this.onKnobAdded);

  final T? Function<T>(Knob<T?> knob) onKnobAdded;

  /// Allows the user to select from a list of objects using a segmented control.
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
}

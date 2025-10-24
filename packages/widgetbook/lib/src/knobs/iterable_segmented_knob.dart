import 'package:meta/meta.dart';

import '../fields/fields.dart';
import 'knob.dart';

@internal
class IterableSegmentedKnob<T> extends Knob<Iterable<T>?> {
  IterableSegmentedKnob({
    required super.label,
    required super.initialValue,
    required this.options,
    super.description,
    this.labelBuilder,
    this.emptySelectionAllowed = true,
  });

  IterableSegmentedKnob.nullable({
    required super.label,
    required super.initialValue,
    required this.options,
    super.description,
    this.labelBuilder,
    this.emptySelectionAllowed = true,
  }) : super(isNullable: true);

  final Iterable<T> options;
  final LabelBuilder<T>? labelBuilder;
  final bool emptySelectionAllowed;

  @override
  List<Field> get fields {
    return [
      IterableSegmentedField<T>(
        name: label,
        values: options,
        initialValue: initialValue,
        emptySelectionAllowed: emptySelectionAllowed,
        labelBuilder:
            labelBuilder ?? IterableSegmentedField.defaultLabelBuilder,
      ),
    ];
  }

  @override
  Iterable<T>? valueFromQueryGroup(Map<String, String> group) {
    return valueOf(label, group);
  }
}

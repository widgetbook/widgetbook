import 'package:meta/meta.dart';

import '../fields/fields.dart';
import 'knob.dart';

@internal
class ObjectSegmentedKnob<T> extends Knob<Set<T>?> {
  ObjectSegmentedKnob({
    required super.label,
    required super.initialValue,
    required this.options,
    super.description,
    this.labelBuilder,
    this.multiSelectionEnabled = true,
    this.emptySelectionAllowed = true,
  });

  ObjectSegmentedKnob.nullable({
    required super.label,
    required super.initialValue,
    required this.options,
    super.description,
    this.labelBuilder,
    this.multiSelectionEnabled = true,
    this.emptySelectionAllowed = true,
  }) : super(isNullable: true);

  final Set<T> options;
  final LabelBuilder<T>? labelBuilder;
  final bool multiSelectionEnabled;
  final bool emptySelectionAllowed;

  @override
  List<Field> get fields {
    return [
      ObjectSegmentedField<T>(
        name: label,
        values: options,
        initialValue: initialValue,
        labelBuilder: labelBuilder ?? ObjectSegmentedField.defaultLabelBuilder,
        multiSelectionEnabled: multiSelectionEnabled,
        emptySelectionAllowed: emptySelectionAllowed,
      ),
    ];
  }

  @override
  Set<T>? valueFromQueryGroup(Map<String, String> group) {
    return valueOf(label, group);
  }
}

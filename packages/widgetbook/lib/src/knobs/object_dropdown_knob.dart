import 'package:meta/meta.dart';

import '../fields/fields.dart';
import 'knob.dart';

@internal
class ObjectDropdownKnob<T> extends Knob<T?> {
  ObjectDropdownKnob({
    required super.label,
    required super.initialValue,
    required this.options,
    super.description,
    this.labelBuilder,
  });

  ObjectDropdownKnob.nullable({
    required super.label,
    required super.initialValue,
    required this.options,
    super.description,
    this.labelBuilder,
  }) : super(isNullable: true);

  final List<T> options;
  final LabelBuilder<T>? labelBuilder;

  @override
  List<Field> get fields {
    return [
      ObjectDropdownField<T>(
        name: label,
        values: options,
        initialValue: initialValue,
        labelBuilder: labelBuilder ?? ObjectDropdownField.defaultLabelBuilder,
      ),
    ];
  }

  @override
  T? valueFromQueryGroup(Map<String, String> group) {
    return valueOf(label, group);
  }
}

import 'package:meta/meta.dart';
import '../fields/fields.dart';
import 'knob.dart';

@internal
class MultiSelectListKnob<T> extends Knob<List<T>?> {
  MultiSelectListKnob({
    required super.label,
    required super.initialValue,
    required this.options,
    super.description,
    this.labelBuilder,
  });

  MultiSelectListKnob.nullable({
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
      MultiSelectField<T>(
        name: label,
        values: options,
        initialValue: initialValue,
        labelBuilder: labelBuilder ?? ListField.defaultLabelBuilder,
      ),
    ];
  }

  @override
  List<T> valueFromQueryGroup(Map<String, String> group) {
    final values = group[label]?.split(',') ?? [];
    return options
        .where((option) => values.contains(option.toString()))
        .toList();
  }
}

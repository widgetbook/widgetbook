import 'package:meta/meta.dart';

import '../fields/fields.dart';
import '../fields/segment_button_field.dart';
import 'knob.dart';

@internal
class SegmentButtonKnob<T> extends Knob<T?> {
  SegmentButtonKnob({
    required super.label,
    required super.initialValue,
    required this.options,
    super.description,
    this.labelBuilder,
  });

  final List<T> options;
  final LabelBuilder<T>? labelBuilder;

  @override
  List<Field> get fields {
    return [
      SegmentButtonField<T>(
        name: label,
        values: options,
        initialValue: initialValue,
        labelBuilder: labelBuilder ?? ListField.defaultLabelBuilder,
      ),
    ];
  }

  @override
  T? valueFromQueryGroup(Map<String, String> group) {
    return valueOf(label, group);
  }
}

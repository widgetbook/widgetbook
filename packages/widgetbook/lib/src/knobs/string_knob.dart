import 'package:meta/meta.dart';

import '../fields/fields.dart';
import 'knob.dart';

@internal
class StringKnob extends Knob<String?> {
  StringKnob({
    required super.label,
    required super.initialValue,
    super.description,
    this.maxLines,
  });

  StringKnob.nullable({
    required super.label,
    required super.initialValue,
    super.description,
    this.maxLines,
  }) : super(isNullable: true);

  final int? maxLines;

  @override
  List<Field> get fields {
    return [
      StringField(
        name: label,
        initialValue: initialValue,
        maxLines: maxLines,
      ),
    ];
  }

  @override
  String? valueFromQueryGroup(Map<String, String> group) {
    return valueOf(label, group);
  }
}

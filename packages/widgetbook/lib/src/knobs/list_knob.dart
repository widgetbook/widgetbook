import 'package:meta/meta.dart';

import '../fields/fields.dart';
import '../state/state.dart';
import 'knob.dart';

@internal
class ListKnob<T> extends Knob<T> {
  ListKnob({
    required super.label,
    required super.value,
    required this.options,
    super.description,
    this.labelBuilder,
  });

  final List<T> options;
  final LabelBuilder<T>? labelBuilder;

  @override
  List<Field> get fields {
    return [
      ListField<T>(
        group: 'knobs',
        name: label,
        values: options,
        initialValue: value,
        labelBuilder: labelBuilder,
        onChanged: (context, value) {
          if (value == null) return;
          WidgetbookState.of(context).updateKnobValue<T>(label, value);
        },
      ),
    ];
  }

  @override
  T valueFromQueryGroup(Map<String, String> group) {
    return options.firstWhere(
      (option) {
        final optionLabel = labelBuilder?.call(option);
        return (optionLabel ?? option.toString()) == group[label];
      },
      orElse: () => value,
    );
  }
}

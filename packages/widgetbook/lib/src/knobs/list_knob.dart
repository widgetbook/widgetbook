import '../fields/fields.dart';
import '../state/state.dart';
import 'knob.dart';

class ListKnob<T> extends Knob<T> {
  ListKnob({
    required super.label,
    required super.value,
    required this.options,
    super.description,
    this.labelBuilder,
  });

  final List<T> options;
  final String Function(T)? labelBuilder;

  @override
  List<Field> get fields {
    return [
      ListField<T>(
        group: 'knobs',
        name: label,
        values: options,
        initialValue: value,
        labelBuilder: labelBuilder,
        onChanged: (context, T? value) {
          if (value == null) return;
          WidgetbookState.of(context).updateKnobValue<T>(label, value);
        },
      ),
    ];
  }
}

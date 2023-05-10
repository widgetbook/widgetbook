import 'package:provider/provider.dart';
import 'package:widgetbook/src/fields/fields.dart';
import 'package:widgetbook/src/knobs/knobs.dart';

class OptionsKnob<T> extends Knob<T> {
  OptionsKnob({
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
          context.read<KnobsNotifier>().update<T>(label, value);
        },
      ),
    ];
  }
}

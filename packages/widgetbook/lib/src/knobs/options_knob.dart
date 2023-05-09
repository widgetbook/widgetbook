import 'package:provider/provider.dart';
import 'package:widgetbook/src/fields/fields.dart';
import 'package:widgetbook/src/knobs/knobs.dart';

class OptionsKnob<T> extends Knob<T> {
  OptionsKnob({
    required super.label,
    required super.value,
    required this.options,
    super.description,
    String Function(T)? labelBuilder,
  }) : this.labelBuilder = labelBuilder ?? _defaultLabelBuilder;

  final List<T> options;
  final String Function(T) labelBuilder;

  static String _defaultLabelBuilder(dynamic value) {
    return value.toString();
  }

  @override
  List<Field> get fields {
    return [
      DropdownField<T>(
        group: 'knobs',
        name: label,
        values: options,
        initialValue: value,
        labelBuilder: labelBuilder,
        codec: FieldCodec(
          toParam: labelBuilder,
          toValue: (param) => options.firstWhere(
            (option) => labelBuilder(option) == param,
            orElse: () => value,
          ),
        ),
        onChanged: (context, T? value) {
          if (value == null) return;
          context.read<KnobsNotifier>().update<T>(label, value);
        },
      ),
    ];
  }
}

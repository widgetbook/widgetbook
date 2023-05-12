import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/fields/fields.dart';
import 'package:widgetbook/src/knobs/bool_knob.dart';
import 'package:widgetbook/src/knobs/color_knob.dart';
import 'package:widgetbook/src/knobs/knobs_builder.dart';
import 'package:widgetbook/src/knobs/number_knob.dart';
import 'package:widgetbook/src/knobs/options_knob.dart';
import 'package:widgetbook/src/knobs/slider_knob.dart';
import 'package:widgetbook/src/knobs/text_knob.dart';

/// This allows stories to have dynamically adjustable parameters.
abstract class Knob<T> {
  Knob({
    required this.label,
    required this.value,
    this.description,
    this.isNullable = false,
  });

  /// This is the current value the knob is set to
  T value;

  /// This is a description the user can put on the knob
  final String? description;

  /// This is the label that's put above a knob
  final String label;

  final bool isNullable;

  @override
  bool operator ==(Object other) {
    return other is Knob<T> &&
        other.value == value &&
        other.label == label &&
        other.description == description;
  }

  @override
  int get hashCode => label.hashCode;

  List<Field> get fields;
}

/// Updates listeners on changes with the knobs
class KnobsNotifier extends ChangeNotifier implements KnobsBuilder {
  final Map<String, Knob> _knobs = <String, Knob>{};

  void clear() {
    _knobs.clear();
    notifyListeners();
  }

  List<Knob> all() => _knobs.values.toList();

  void update<T>(String label, T value) {
    _knobs[label]!.value = value;
    notifyListeners();
  }

  T register<T>(Knob<T> knob) {
    return _knobs.putIfAbsent(
      knob.label,
      () {
        Future.microtask(notifyListeners);
        return knob;
      },
    ).value;
  }

  void unregister(Knob knob) {
    _knobs.remove(knob.label);
  }

  @override
  bool boolean({
    required String label,
    String? description,
    bool initialValue = false,
  }) {
    return register(
      BoolKnob(
        label: label,
        description: description,
        value: initialValue,
      ),
    );
  }

  @override
  Color color({
    required String label,
    required Color initialValue,
    String? description,
  }) {
    return register(
      ColorKnob(
        label: label,
        value: initialValue,
      ),
    );
  }

  @override
  bool? nullableBoolean({
    required String label,
    String? description,
    bool? initialValue = false,
  }) {
    return register(
      NullableBoolKnob(
        label: label,
        description: description,
        value: initialValue,
      ),
    );
  }

  @override
  String text({
    required String label,
    String? description,
    String initialValue = '',
    int? maxLines = 1,
  }) {
    return register(
      TextKnob(
        label: label,
        value: initialValue,
        description: description,
        maxLines: maxLines,
      ),
    );
  }

  @override
  String? nullableText({
    required String label,
    String? description,
    String? initialValue,
    int? maxLines = 1,
  }) {
    return register(
      NullableTextKnob(
        label: label,
        value: initialValue,
        description: description,
        maxLines: maxLines,
      ),
    );
  }

  @override
  double slider({
    required String label,
    double? initialValue,
    String? description,
    double? max,
    double? min,
    int? divisions,
  }) {
    initialValue ??= max ?? min ?? 10;
    return register(
      SliderKnob(
        label: label,
        value: initialValue,
        description: description,
        min: min ?? initialValue - 10,
        max: max ?? initialValue + 10,
        divisions: divisions,
      ),
    );
  }

  @override
  double? nullableSlider({
    required String label,
    double? initialValue,
    String? description,
    double? max,
    double? min,
    int? divisions,
  }) {
    initialValue ??= max ?? min ?? 10;
    return register(
      NullableSliderKnob(
        label: label,
        value: initialValue,
        description: description,
        min: min ?? initialValue - 10,
        max: max ?? initialValue + 10,
        divisions: divisions,
      ),
    );
  }

  @override
  num number({
    required String label,
    String? description,
    num initialValue = 0,
  }) {
    return register(
      NumberKnob(
        label: label,
        value: initialValue,
        description: description,
      ),
    );
  }

  @override
  num? nullableNumber({
    required String label,
    String? description,
    num? initialValue = 0,
  }) {
    return register(
      NullableNumberKnob(
        label: label,
        value: initialValue,
        description: description,
      ),
    );
  }

  @override
  T options<T>({
    required String label,
    required List<T> options,
    String? description,
    String Function(T)? labelBuilder,
  }) {
    assert(options.isNotEmpty, 'Must specify at least one option');
    return register(
      OptionsKnob(
        label: label,
        value: options.first,
        description: description,
        options: options,
        labelBuilder: labelBuilder,
      ),
    );
  }
}

extension Knobs on BuildContext {
  /// Creates adjustable parameters for the WidgetbookUseCase
  KnobsBuilder get knobs => watch<KnobsNotifier>();
}

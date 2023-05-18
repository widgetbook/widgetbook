import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'bool_knob.dart';
import 'color_knob.dart';
import 'knob.dart';
import 'knobs_builder.dart';
import 'number_knob.dart';
import 'options_knob.dart';
import 'slider_knob.dart';
import 'text_knob.dart';

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

  void updateNullability(String label, bool isNull) {
    _knobs[label]!.isNull = isNull;
    notifyListeners();
  }

  T? register<T>(Knob<T> knob) {
    final cachedKnob = _knobs.putIfAbsent(
      knob.label,
      () {
        Future.microtask(notifyListeners);
        return knob;
      },
    );

    return cachedKnob.isNull ? null : cachedKnob.value;
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
    )!;
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
    )!;
  }

  @override
  bool? nullableBoolean({
    required String label,
    String? description,
    bool? initialValue = false,
  }) {
    return register<bool?>(
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
    )!;
  }

  @override
  String? nullableText({
    required String label,
    String? description,
    String? initialValue,
    int? maxLines = 1,
  }) {
    return register<String?>(
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
    )!;
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
    return register<double?>(
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
        value: initialValue.toDouble(),
        description: description,
      ),
    )!;
  }

  @override
  num? nullableNumber({
    required String label,
    String? description,
    num? initialValue = 0,
  }) {
    return register<num?>(
      NullableNumberKnob(
        label: label,
        value: initialValue?.toDouble(),
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
    )!;
  }
}

extension Knobs on BuildContext {
  /// Creates adjustable parameters for the WidgetbookUseCase
  KnobsBuilder get knobs => watch<KnobsNotifier>();
}

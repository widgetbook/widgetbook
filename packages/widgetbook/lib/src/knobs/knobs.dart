import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/knobs/bool_knob.dart';
import 'package:widgetbook/src/knobs/knobs_builder.dart';
import 'package:widgetbook/src/knobs/nullable_bool_knob.dart';
import 'package:widgetbook/src/knobs/nullable_text_knob.dart';
import 'package:widgetbook/src/knobs/slider_knob.dart';
import 'package:widgetbook/src/knobs/text_knob.dart';
import 'package:widgetbook/src/repositories/selected_story_repository.dart';

abstract class Knob<T> {
  Knob({
    required this.label,
    this.description,
    required this.value,
  });

  /// This is the current value the knob is set to
  T value;

  /// This is a description the user can put on the knob
  final String? description;

  /// This is the label that's put above a knob
  final String label;

  @override
  bool operator ==(Object other) {
    return other is Knob<T> &&
        other.value == value &&
        other.label == label &&
        other.description == description;
  }

  @override
  int get hashCode => label.hashCode;

  Widget build();
}

class KnobsNotifier extends ChangeNotifier implements KnobsBuilder {
  KnobsNotifier(this._selectedStoryRepository) {
    _selectedStoryRepository.getStream().listen((event) => notifyListeners());
  }

  final SelectedStoryRepository _selectedStoryRepository;

  final Map<String, Map<String, Knob>> _knobs = <String, Map<String, Knob>>{};

  List<Knob> all() {
    if (!_selectedStoryRepository.isSet()) {
      return [];
    }
    final story = _selectedStoryRepository.item;
    return _knobs[story!.name]?.values.toList() ?? [];
  }

  void update<T>(String label, T value) {
    if (!_selectedStoryRepository.isSet()) {
      return;
    }
    _knobs[_selectedStoryRepository.item!.name]![label]!.value = value;
    notifyListeners();
  }

  T _addKnob<T>(Knob<T> value) {
    final story = _selectedStoryRepository.item!;
    final knobs = _knobs.putIfAbsent(story.name, () => <String, Knob>{});

    return (knobs.putIfAbsent(value.label, () {
      Future.microtask(notifyListeners);
      return value;
    }) as Knob<T>)
        .value;
  }

  @override
  bool boolean({
    required String label,
    String? description,
    bool initialValue = false,
  }) =>
      _addKnob(
        BoolKnob(
          label: label,
          description: description,
          value: initialValue,
        ),
      );

  @override
  bool? nullableBoolean({
    required String label,
    String? description,
    bool? initialValue = false,
  }) =>
      _addKnob(
        NullableBoolKnob(
          label: label,
          description: description,
          value: initialValue,
        ),
      );

  @override
  String text({
    required String label,
    String? description,
    String initialValue = '',
  }) =>
      _addKnob(TextKnob(
        label: label,
        value: initialValue,
        description: description,
      ));

  @override
  String? nullableText({
    required String label,
    String? description,
    String? initialValue,
  }) =>
      _addKnob(
        NullableTextKnob(
          label: label,
          value: initialValue,
          description: description,
        ),
      );

  @override
  double slider({
    required String label,
    required double initialValue,
    String? description,
    double max = 1,
    double min = 0,
    int? divisions,
  }) =>
      _addKnob(
        SliderKnob(
          label: label,
          value: initialValue,
          description: description,
          min: min,
          max: max,
          divisions: divisions,
        ),
      );
}

extension Knobs on BuildContext {
  KnobsBuilder get knobs => watch<KnobsNotifier>();
}

/// Provides the description to the Knob
class KnobWrapper extends StatelessWidget {
  const KnobWrapper({
    required this.child,
    this.description,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        child,
        if (description != null) ...[
          const SizedBox(height: 10),
          Text(description!)
        ]
      ],
    );
  }
}

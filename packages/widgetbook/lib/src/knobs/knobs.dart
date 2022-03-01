import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/knobs/bool_knob.dart';
import 'package:widgetbook/src/repositories/selected_story_repository.dart';

import 'knobs_builder.dart';

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

  Widget build();
}

extension Knobs on BuildContext {
  KnobsBuilder get knobs => watch<KnobsNotifier>();
}

class KnobsNotifier extends ChangeNotifier implements KnobsBuilder {
  KnobsNotifier(this._selectedStoryRepository) {
    _selectedStoryRepository.getStream().listen((event) => notifyListeners());
  }

  final SelectedStoryRepository _selectedStoryRepository;
  final Map<String, Map<String, Knob>> _knobs = <String, Map<String, Knob>>{};

  void update<T>(String label, T value) {
    if (!_selectedStoryRepository.isSet()) {
      return;
    }
    _knobs[_selectedStoryRepository.item!.name]![label]!.value = value;
    notifyListeners();
  }

  List<Knob> all() {
    if (!_selectedStoryRepository.isSet()) {
      return [];
    }
    final story = _selectedStoryRepository.item;
    return _knobs[story!.name]?.values.toList() ?? [];
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
}

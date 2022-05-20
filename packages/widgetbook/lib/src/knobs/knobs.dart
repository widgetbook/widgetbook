import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/knobs/bool_knob.dart';
import 'package:widgetbook/src/knobs/knobs_builder.dart';
import 'package:widgetbook/src/knobs/nullable_checkbox.dart';
import 'package:widgetbook/src/knobs/number_knob.dart';
import 'package:widgetbook/src/knobs/options_knob.dart';
import 'package:widgetbook/src/knobs/slider_knob.dart';
import 'package:widgetbook/src/knobs/text_knob.dart';
import 'package:widgetbook/src/repositories/selected_story_repository.dart';
import 'package:widgetbook/src/utils/styles.dart';
import 'package:widgetbook/widgetbook.dart';

/// This allows stories to have dynamically adjustable parameters.
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

/// Updates listeners on changes with the knobs
class KnobsNotifier extends ChangeNotifier implements KnobsBuilder {
  KnobsNotifier(this._selectedStoryRepository) {
    _selectedStoryRepository.getStream().listen((event) => notifyListeners());
  }

  final SelectedStoryRepository _selectedStoryRepository;

  final Map<WidgetbookUseCase, Map<String, Knob>> _knobs =
      <WidgetbookUseCase, Map<String, Knob>>{};

  List<Knob> all() {
    if (!_selectedStoryRepository.isSet()) {
      return [];
    }
    final story = _selectedStoryRepository.item;
    return _knobs[story]?.values.toList() ?? [];
  }

  void update<T>(String label, T value) {
    if (!_selectedStoryRepository.isSet()) {
      return;
    }
    _knobs[_selectedStoryRepository.item]![label]!.value = value;
    notifyListeners();
  }

  T _addKnob<T>(Knob<T> value) {
    final story = _selectedStoryRepository.item!;
    final knobs = _knobs.putIfAbsent(story, () => <String, Knob>{});
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
    double? initialValue,
    String? description,
    double? max,
    double? min,
    int? divisions,
  }) {
    initialValue ??= max ?? min ?? 10;
    return _addKnob(
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
    return _addKnob(
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
  }) =>
      _addKnob(
        NumberKnob(
          label: label,
          value: initialValue,
          description: description,
        ),
      );

  @override
  num? nullableNumber({
    required String label,
    String? description,
    num? initialValue = 0,
  }) =>
      _addKnob(
        NullableNumberKnob(
          label: label,
          value: initialValue,
          description: description,
        ),
      );

  @override
  T options<T>({
    required String label,
    String? description,
    required List<Option<T>> options,
  }) {
    assert(options.isNotEmpty, 'Must specify at least one option');
    return _addKnob(
      OptionsKnob(
        label: label,
        value: options[0].value,
        description: description,
        options: options,
      ),
    );
  }
}

extension Knobs on BuildContext {
  /// Creates adjustable parameters for the WidgetbookUseCase
  KnobsBuilder get knobs => watch<KnobsNotifier>();
}

/// Provides the description to the Knob
class KnobWrapper extends StatelessWidget {
  const KnobWrapper({
    required this.child,
    required this.description,
    required this.title,
    this.nullableCheckbox,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final String? description;
  final String title;
  final NullableCheckbox? nullableCheckbox;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Styles.notCompletelyWhite),
            ),
            const Spacer(),
            if (nullableCheckbox != null) ...[
              const Text('No Value', style: TextStyle(fontSize: 14)),
              const SizedBox(width: 10),
              nullableCheckbox!,
            ]
          ],
        ),
        if (description != null) ...[
          Text(
            description!,
            style: const TextStyle(fontSize: 14),
          ),
        ],
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}

/// Data object that is used within the options knob
class Option<T> {
  const Option({
    required this.label,
    required this.value,
  });

  /// The label that will be displayed in the dropdown menu.
  final String label;

  /// The value this label represents
  final T value;
}

class KnobConfig<T> {
  /// Creates a new [KnobConfig] using a [label] and a [value].
  ///
  /// Given the following Widgetbook URL:
  /// ```url
  /// /?knobs={size:2,color:blue,disabled:true}
  /// ```
  ///
  /// Then this would be:
  /// ```dart
  /// const KnobConfig('size', 2);
  /// const KnobConfig('color', 'blue');
  /// const KnobConfig('enabled', false);
  /// ```
  const KnobConfig(this.label, this.value);

  static const nullabilitySymbol = '??';

  /// The knob's label.
  final String label;

  /// The value of the entry must be a query string that can be parsed by the
  /// knob. The easiest way to get the value is to use the URL query string
  /// of a Widgetbook web build.
  final T value;

  MapEntry<String, T> toMapEntry() {
    return MapEntry(label, value);
  }
}

class NullKnobConfig extends KnobConfig<String> {
  /// Creates a new [KnobConfig] for the nullable knobs
  /// with a null value.
  ///
  /// ```dart
  /// const NullKnobConfig('label');
  /// ```
  const NullKnobConfig(String label)
    : super(
        label,
        KnobConfig.nullabilitySymbol,
      );
}

class IntKnobConfig extends KnobConfig<int> {
  /// Creates a new [KnobConfig] for `knobs.int`.
  ///
  /// ```dart
  /// const IntKnobConfig('label', 1);
  /// ```
  const IntKnobConfig(super.label, super.value);
}

class DoubleKnobConfig extends KnobConfig<double> {
  /// Creates a new [KnobConfig] for `knobs.double`.
  ///
  /// ```dart
  /// const DoubleKnobConfig('label', 2.0);
  /// ```
  const DoubleKnobConfig(super.label, super.value);
}

class StringKnobConfig extends KnobConfig<String> {
  /// Creates a new [KnobConfig] for `knobs.string`.
  ///
  /// ```dart
  /// const StringKnobConfig('label', 'value');
  /// ```
  const StringKnobConfig(super.label, super.value);
}

class BooleanKnobConfig extends KnobConfig<bool> {
  /// Creates a new [KnobConfig] for `knobs.boolean`.
  ///
  /// ```dart
  /// const BooleanKnobConfig('label', true);
  /// const BooleanKnobConfig('label', false);
  /// ```
  const BooleanKnobConfig(super.label, super.value);
}

class ColorKnobConfig extends KnobConfig<String> {
  /// Creates a new [KnobConfig] for `knobs.color`.
  ///
  /// ```dart
  /// const ColorKnobConfig('label', 'ff000000'); // black
  /// const ColorKnobConfig('label', 'ff00ff00'); // green
  /// ```
  const ColorKnobConfig(super.label, super.colorInAlphaHex);
}

class DurationKnobConfig extends KnobConfig<int> {
  /// Creates a new [KnobConfig] for `knobs.duration`.
  ///
  /// ```dart
  /// const DurationKnobConfig('label', 1000); // 1 second
  /// const DurationKnobConfig('label', 500); // 0.5 second
  /// ```
  const DurationKnobConfig(super.label, super.durationInMilliseconds);
}

class DateTimeKnobConfig extends KnobConfig<String> {
  /// Creates a new [KnobConfig] for `knobs.dateTime`.
  /// The [dateTimeInSimpleFormat] is a string representation of the
  /// [DateTime] object in `yyyy-MM-dd HH:mm` format.
  ///
  /// ```dart
  /// const DateTimeKnobConfig('label', '2020-01-31 16:10');
  /// ```
  const DateTimeKnobConfig(super.label, super.dateTimeInSimpleFormat);
}

@Deprecated('Use `ObjectKnobConfig` instead.')
class ListKnobConfig extends KnobConfig<String> {
  /// Creates a new [KnobConfig] for `knobs.list`.
  /// The easiest way to get the `itemLabel` is to check the URL query string
  /// of a Widgetbook web build.
  ///
  /// ```dart
  /// const ListKnobConfig('label', 'selected-item-label');
  /// ```
  const ListKnobConfig(super.label, super.itemLabel);
}

class IterableKnobConfig extends KnobConfig<String> {
  /// Creates a new [KnobConfig] for `knobs.iterable`.
  /// The easiest way to get the [labelsList] is to check the
  /// URL query string of a Widgetbook web build.
  ///
  /// ```dart
  /// const IterableKnobConfig('label', '[item1,item2,item3]');
  /// ```
  const IterableKnobConfig(super.label, super.labelsList);
}

class ObjectKnobConfig extends KnobConfig<String> {
  /// Creates a new [KnobConfig] for `knobs.object`.
  /// The easiest way to get the [objectLabel] is to check the
  /// URL query string of a Widgetbook web build.
  ///
  /// ```dart
  /// const ObjectKnobConfig('label', 'selected-item-label');
  /// ```
  const ObjectKnobConfig(super.label, super.objectLabel);
}

class MultiFieldKnobConfig extends KnobConfig<Map<String, dynamic>> {
  /// All first-class knobs provided by Widgetbook are single-field knobs.
  /// This means that they have only one field. For example, the `knobs.int`
  /// knob has only one `IntField`.
  ///
  /// But in other cases, you might want to create a custom knob that has more
  /// than one field. For example, if you want to create a custom knob that
  /// allows the user to select a user, you might want to create a custom knob
  /// that has two fields: one for the name and one for the age.
  ///
  /// ```dart
  /// class UserKnob extends Knob<User> {
  ///   UserKnob({
  ///     required super.label,
  ///     required super.initialValue,
  ///   });
  ///
  ///   @override
  ///   List<Field> get fields => [
  ///     StringInputField(
  ///       name: '$label.name',
  ///       initialValue: initialValue.name,
  ///     ),
  ///     IntInputField(
  ///       name: '$label.age',
  ///       initialValue: initialValue.age,
  ///     ),
  ///   ];
  /// }
  /// ```
  ///
  /// Given that the knob's label is "user", then this knob can be configured
  /// as follows:
  ///
  /// ```dart
  /// const MultiFieldKnobConfig({
  ///   'user.name': 'John Doe',
  ///   'user.age': 42,
  /// });
  /// ```
  ///
  /// For more info, check out our docs:
  /// https://docs.widgetbook.io/knobs/custom-knob
  const MultiFieldKnobConfig(Map<String, dynamic> fields) : super('', fields);
}

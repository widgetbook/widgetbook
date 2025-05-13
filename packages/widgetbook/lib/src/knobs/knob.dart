import 'package:flutter/widgets.dart';

import '../fields/fields.dart';
import '../navigation/navigation.dart';

/// Allows [WidgetbookUseCase]s to have dynamically adjustable parameters.
@optionalTypeArgs
abstract class Knob<T> extends FieldsComposable<T> {
  Knob({
    required String label,
    super.description,
    @Deprecated('Use initialValue instead.') T? value,
    T? initialValue,
    super.isNullable,
    @Deprecated(
      'This parameter is not used anymore. '
      'It defaults to [value == null] instead of [false]',
    )
    bool isNull = false,
  })  : this.initialValue = (initialValue ?? value) as T,
        super(name: label);

  /// The initial value the knob is set to.
  final T initialValue;

  // A workaround to avoid breaking changes
  String get label => name;

  @Deprecated(
    'Knobs are stateless. '
    'They know about their value from [valueFromQueryGroup]. '
    'You can use [initialValue] if you want to set a default value. ',
  )
  // A workaround to avoid breaking changes
  T? get value => null;

  @override
  String get groupName => 'knobs';

  @override
  bool operator ==(Object other) {
    return other is Knob<T> &&
        other.initialValue == initialValue &&
        other.name == name &&
        other.description == description;
  }

  @override
  int get hashCode => name.hashCode;

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'group': groupName,
      'nullable': isNullable,
      'fields': fields.map((field) => field.toFullJson()).toList(),
    };
  }
}

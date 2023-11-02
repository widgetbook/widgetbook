import 'package:flutter/widgets.dart';

import '../fields/fields.dart';
import '../navigation/navigation.dart';
import '../settings/settings.dart';
import '../state/state.dart';

/// Allows [WidgetbookUseCase]s to have dynamically adjustable parameters.
@optionalTypeArgs
abstract class Knob<T> extends FieldsComposable<T> {
  Knob({
    required this.label,
    this.description,
    @Deprecated('Use initialValue instead.') T? value,
    T? initialValue,
    this.isNullable = false,
    @Deprecated(
      'This parameter is not used anymore. '
      'It defaults to [value == null] instead of [false]',
    )
    this.isNull = false,
  }) : this.initialValue = (initialValue ?? value) as T {
    this.isNull = this.initialValue == null;
  }

  /// The label that's put above a knob.
  final String label;

  /// The Description of what the user can put on the knob.
  final String? description;

  /// The initial value the knob is set to.
  final T initialValue;

  final bool isNullable;

  @Deprecated(
    'Knobs are stateless. '
    'They know about their value from [valueFromQueryGroup]. '
    'You can use [initialValue] if you want to set a default value. ',
  )
  T? value;

  bool isNull;

  @override
  String get groupName => 'knobs';

  @override
  Widget buildFields(BuildContext context) {
    return NullableSetting(
      name: label,
      description: description,
      isNull: isNull,
      isNullable: isNullable,
      onChangedNullable: (isEnabled) {
        WidgetbookState.of(context).knobs.updateNullability(
              label,
              !isEnabled,
            );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: fields
            .map(
              (field) => Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 4.0,
                ),
                child: field.build(context, groupName),
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is Knob<T> &&
        other.initialValue == initialValue &&
        other.label == label &&
        other.description == description;
  }

  @override
  int get hashCode => label.hashCode;

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': label,
      'group': groupName,
      'nullable': isNullable,
      'fields': fields.map((field) => field.toFullJson()).toList(),
    };
  }
}

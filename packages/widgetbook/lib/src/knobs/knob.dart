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
    required this.value,
    this.description,
    this.isNull = false,
  });

  /// This is the current value the knob is set to
  T value;

  /// This is a description the user can put on the knob
  final String? description;

  /// This is the label that's put above a knob
  final String label;

  bool isNull;

  bool get isNullable => null is T;

  @override
  String get groupName => 'knobs';

  @override
  Widget buildFields(BuildContext context) {
    return KnobProperty<T>(
      name: label,
      description: description,
      value: value,
      isNullable: isNullable,
      changedNullable: (isEnabled) {
        WidgetbookState.of(context).updateKnobNullability(
          label,
          !isEnabled,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: fields //
            .map((field) => field.build(context, groupName))
            .toList(),
      ),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is Knob<T> &&
        other.value == value &&
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

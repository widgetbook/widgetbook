import 'package:flutter/widgets.dart';

import '../addons/addons.dart';
import '../fields/fields.dart';
import '../navigation/navigation.dart';

/// Base class for interactive controls that allow dynamic parameter adjustment.
///
/// [Knob]s provide interactive controls within [WidgetbookUseCase]s that allow
/// users to dynamically adjust widget parameters at runtime. Unlike [WidgetbookAddon]s
/// which affect all use cases globally, knobs are specific to individual use cases
/// and help test different states and configurations of widgets.
///
/// Knobs appear in the settings panel when a use case is selected and their
/// values are synchronized with URL query parameters, making configurations
/// shareable and persistent.
///
/// Learn more:
/// * https://docs.widgetbook.io/knobs/overview
/// * https://docs.widgetbook.io/knobs/custom-knob
@optionalTypeArgs
abstract class Knob<T> extends FieldsComposable<T> {
  /// Creates a new [Knob] with the specified configuration.
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
  }) : this.initialValue = (initialValue ?? value) as T,
       super(name: label);

  /// The default value for this knob.
  ///
  /// This value is used when the knob is first displayed or when no value
  /// has been set by the user.
  final T initialValue;

  /// The display label for this knob.
  ///
  /// This is an alias for [name] to maintain compatibility with older APIs.
  /// The label appears in the settings panel next to the knob's input control.
  String get label => name;

  /// @nodoc
  @Deprecated(
    'Knobs are stateless. '
    'They know about their value from [valueFromQueryGroup]. '
    'You can use [initialValue] if you want to set a default value. ',
  )
  T? get value => null; // A workaround to avoid breaking changes

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

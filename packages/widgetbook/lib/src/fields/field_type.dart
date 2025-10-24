import 'dart:ui';

/// Defines the available field types that can be used in Widgetbook for
/// creating interactive controls in the UI.
enum FieldType {
  /// For fields that have a [boolean] value.
  boolean,

  /// For fields that have a [Color] value.
  color,

  /// For fields that have a [double] value, represented as a slider.
  doubleSlider,

  /// For fields that have a [double] value, represented as an input field.
  doubleInput,

  /// For fields that have a [String] value.
  string,

  /// For fields that have a [Duration] value.
  duration,

  /// For fields that have a [DateTime] value.
  dateTime,

  /// For fields that have a [int] value, represented as a slider.
  intInput,

  /// For fields that have a [int] value, represented as an input field.
  intSlider,

  /// @nodoc
  @Deprecated('Use `objectDropdown` instead.')
  list,

  /// For fields that have a [Object] value, represented as a dropdown.
  objectDropdown,

  /// For fields that have a [Object] value, represented as a segmented button.
  objectSegmented,

  /// For fields that have a [Iterable] value, represented as a segmented button.
  iterableSegmented,
}

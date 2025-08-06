// ignore_for_file: deprecated_member_use_from_same_package

import 'package:flutter/material.dart';

import '../../fields/fields.dart';
import '../common/common.dart';

/// A [WidgetbookAddon] for scaling text content to test accessibility
/// and responsive typography.
///
/// The text scale addon allows developers to test their UI components
/// with different text scale factors, which is essential for ensuring
/// accessibility compliance and proper layout behavior at various text sizes.
///
/// Learn more: https://docs.widgetbook.io/addons/text-scale-addon
class TextScaleAddon extends WidgetbookAddon<double> {
  /// Creates a new instance of [TextScaleAddon].
  TextScaleAddon({
    @Deprecated('Use TextScaleAddon.min and TextScaleAddon.max instead')
    this.scales,
    this.initialScale,
    this.min = 0.5,
    this.max = 2.0,
    this.divisions = 6,
  }) : assert(
         scales == null || scales.isNotEmpty,
         'scales must not be empty, if set',
       ),
       assert(
         scales == null ||
             initialScale == null ||
             scales.contains(initialScale),
         'initialScale must be in scales',
       ),
       super(
         name: 'Text scale',
       );

  /// @nodoc
  @Deprecated('Use TextScaleAddon.min and TextScaleAddon.max instead')
  final List<double>? scales;

  /// Initial text scale factor to display when the addon loads.
  ///
  /// Defaults to 1.0 (normal scale) if not specified.
  /// Must be within the [min] to [max] range in slider mode,
  /// or contained in [scales] list in discrete mode.
  final double? initialScale;

  /// Minimum text scale factor for slider mode.
  ///
  /// Defaults to 0.5, which represents 50% of normal text size.
  /// Should be a positive value less than [max].
  final double min;

  /// Maximum text scale factor for slider mode.
  ///
  /// Defaults to 2.0, which represents 200% of normal text size.
  /// Should be greater than [min] to provide a meaningful range.
  final double max;

  /// Number of discrete steps in the slider control.
  ///
  /// Defaults to 6, providing smooth scaling transitions.
  /// Higher values offer finer control but may be less practical for testing.
  final int divisions;

  @override
  List<Field> get fields {
    // Fallback to old implementation if scales are provided
    if (scales != null) {
      return [
        ObjectDropdownField<double>(
          name: 'factor',
          values: scales!,
          initialValue: initialScale ?? scales!.first,
          labelBuilder: (scale) => scale.toStringAsFixed(2),
        ),
      ];
    }

    return [
      DoubleSliderField(
        name: 'factor',
        initialValue: initialScale ?? 1.0,
        min: min,
        max: max,
        divisions: divisions,
      ),
    ];
  }

  @override
  double valueFromQueryGroup(Map<String, String> group) {
    return valueOf('factor', group)!;
  }

  @override
  Widget buildUseCase(
    BuildContext context,
    Widget child,
    double setting,
  ) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: TextScaler.linear(setting),
      ),
      child: child,
    );
  }
}

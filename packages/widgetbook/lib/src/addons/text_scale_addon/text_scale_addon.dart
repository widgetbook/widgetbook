// [MediaQuery.textScaleFactor] is deprecated in Flutter 3.16.0,
// Since our minimum Flutter version is 3.7.0, we cannot use [TextScaler] yet.
// More info: https://docs.flutter.dev/release/breaking-changes/deprecate-textscalefactor
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../../fields/fields.dart';
import '../common/common.dart';

/// A [WidgetbookAddon] for changing the active [MediaQueryData.textScaleFactor]
/// via [MediaQuery].
class TextScaleAddon extends WidgetbookAddon<double> {
  TextScaleAddon({
    required this.scales,
    this.initialScale,
  })  : assert(
          scales.isNotEmpty,
          'scales cannot be empty',
        ),
        assert(
          initialScale == null || scales.contains(initialScale),
          'initialScale must be in scales',
        ),
        super(
          name: 'Text scale',
        );

  final double? initialScale;
  final List<double> scales;

  @override
  List<Field> get fields {
    return [
      ListField<double>(
        name: 'factor',
        values: scales,
        initialValue: initialScale ?? scales.first,
        labelBuilder: (scale) => scale.toStringAsFixed(2),
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
        textScaleFactor: setting,
      ),
      child: child,
    );
  }
}

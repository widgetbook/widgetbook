import 'package:flutter/material.dart';

import '../../fields/fields.dart';
import '../common/common.dart';

/// A [WidgetbookAddon] for changing the active [MediaQueryData.textScaleFactor]
/// via [MediaQuery].
class TextScaleAddon extends WidgetbookAddon<double> {
  TextScaleAddon({
    required this.scales,
    double? initialScale,
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
          initialSetting: initialScale ?? scales.first,
        );

  final List<double> scales;

  @override
  List<Field> get fields {
    return [
      ListField<double>(
        group: slugName,
        name: 'factor',
        values: scales,
        initialValue: initialSetting,
        labelBuilder: (scale) => scale.toStringAsFixed(2),
      ),
    ];
  }

  @override
  double settingFromQueryGroup(Map<String, String> group) {
    return double.parse(
      group['factor'] ?? initialSetting.toStringAsFixed(2),
    );
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

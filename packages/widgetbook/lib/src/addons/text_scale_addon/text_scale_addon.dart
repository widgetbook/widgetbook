import 'package:flutter/material.dart';

import '../../fields/fields.dart';
import '../common/common.dart';
import 'text_scale_setting.dart';

/// A [WidgetbookAddOn] for changing the active [MediaQueryData.textScaleFactor]
/// via [MediaQuery].
class TextScaleAddon extends WidgetbookAddOn<TextScaleSetting> {
  TextScaleAddon({
    required List<double> scales,
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
          initialSetting: TextScaleSetting(
            textScales: scales,
            activeTextScale: initialScale ?? scales.first,
          ),
        );

  @override
  List<Field> get fields {
    return [
      ListField<double>(
        group: slugName,
        name: 'factor',
        values: initialSetting.textScales,
        initialValue: initialSetting.activeTextScale,
        labelBuilder: (scale) => scale.toStringAsFixed(2),
      ),
    ];
  }

  @override
  TextScaleSetting settingFromQueryGroup(Map<String, String> group) {
    return TextScaleSetting(
      textScales: initialSetting.textScales,
      activeTextScale: double.parse(
        group['factor'] ?? initialSetting.activeTextScale.toStringAsFixed(2),
      ),
    );
  }

  @override
  Widget buildUseCase(
    BuildContext context,
    Widget child,
    TextScaleSetting setting,
  ) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaleFactor: setting.activeTextScale,
      ),
      child: child,
    );
  }
}

import 'package:flutter/material.dart';

import '../../fields/fields.dart';
import '../common/common.dart';
import 'text_scale_setting.dart';

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

  /// ?text-scale={factor:1.00}
  @override
  List<Field> get fields {
    return [
      ListField<double>(
        group: slugName,
        name: 'factor',
        values: setting.textScales,
        initialValue: setting.activeTextScale,
        labelBuilder: (scale) => scale.toStringAsFixed(2),
        onChanged: (_, scale) {
          if (scale == null) return;

          updateSetting(
            setting.copyWith(
              activeTextScale: scale,
            ),
          );
        },
      ),
    ];
  }

  @override
  Widget buildUseCase(BuildContext context, Widget child) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaleFactor: setting.activeTextScale,
      ),
      child: child,
    );
  }
}

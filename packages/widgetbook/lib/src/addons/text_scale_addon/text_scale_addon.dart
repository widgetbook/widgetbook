import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../fields/fields.dart';

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
        values: setting.textScales,
        labelBuilder: (scale) => scale.toStringAsFixed(2),
        codec: FieldCodec(
          toParam: (scale) => scale.toStringAsFixed(2),
          toValue: (param) => setting.textScales.firstWhere(
            (scale) => scale.toStringAsFixed(2) == param,
            orElse: () => setting.activeTextScale,
          ),
        ),
        onChanged: (scale) {
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

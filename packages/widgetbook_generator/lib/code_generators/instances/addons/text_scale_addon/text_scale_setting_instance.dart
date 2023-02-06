import 'package:widgetbook_generator/code_generators/instances/double_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/instance.dart';
import 'package:widgetbook_generator/code_generators/instances/list_instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';

class TextScaleSettingInstance extends Instance {
  TextScaleSettingInstance({
    required List<double> textScales,
  }) : super(
          name: 'TextScaleSetting',
          properties: [
            Property(
              key: 'textScales',
              instance: ListInstance(
                instances: textScales.map(DoubleInstance.value).toList(),
              ),
            ),
            Property(
              key: 'activeTextScale',
              instance: DoubleInstance.value(textScales.first),
            ),
          ],
        );
}

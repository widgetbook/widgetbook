import 'package:widgetbook_generator/code_generators/instances/addons/addon_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/addons/text_scale_addon/text_scale_setting_instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';

class TextScaleAddonInstance extends AddOnInstance {
  TextScaleAddonInstance({
    required List<double> textScales,
  }) : super(
          name: 'TextScaleAddon',
          properties: [
            Property(
              key: 'setting',
              instance: TextScaleSettingInstance(
                textScales: textScales,
              ),
            ),
          ],
        );
}

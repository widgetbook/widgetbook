import 'package:widgetbook_generator/code_generators/instances/addons/addon_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/addons/material_theme_addon/material_theme_setting_instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';
import 'package:widgetbook_generator/models/widgetbook_theme_data.dart';

class MaterialThemeAddonInstance extends AddOnInstance {
  MaterialThemeAddonInstance({
    required List<WidgetbookThemeData> themes,
  }) : super(
          name: 'MaterialThemeAddon',
          properties: [
            Property(
              key: 'setting',
              instance: MaterialThemeSettingInstance(
                themes: themes,
                defaultTheme: themes.firstWhere(
                  (element) => element.isDefault,
                  orElse: () => themes.first,
                ),
              ),
            ),
          ],
        );
}

import 'package:widgetbook_generator/code_generators/instances/addons/addon_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/addons/theme_addon/theme_addon.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';
import 'package:widgetbook_generator/models/widgetbook_theme_data.dart';

class CustomThemeAddonInstance extends AddOnInstance {
  CustomThemeAddonInstance({
    required String themeType,
    required List<WidgetbookThemeData> themes,
  }) : super(
          name: 'CustomThemeAddon',
          genericParameters: [
            themeType,
          ],
          properties: [
            Property(
              key: 'setting',
              instance: ThemeSettingInstance(
                themeType: themeType,
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

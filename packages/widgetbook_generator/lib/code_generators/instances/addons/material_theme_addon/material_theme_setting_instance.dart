import 'package:widgetbook_generator/code_generators/instances/instance.dart';
import 'package:widgetbook_generator/code_generators/instances/list_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/theme_instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';
import 'package:widgetbook_generator/models/widgetbook_theme_data.dart';

class MaterialThemeSettingInstance extends Instance {
  MaterialThemeSettingInstance({
    required List<WidgetbookThemeData> themes,
    required WidgetbookThemeData defaultTheme,
  }) : super(
          name: 'MaterialThemeSetting',
          properties: [
            Property(
              key: 'themes',
              instance: ListInstance(
                instances: themes.map((e) => ThemeInstance(theme: e)).toList(),
              ),
            ),
            Property(
              key: 'activeTheme',
              instance: ThemeInstance(theme: defaultTheme),
            ),
          ],
        );
}

import 'package:widgetbook_generator/code_generators/instances/app_info_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/device_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/instance.dart';
import 'package:widgetbook_generator/code_generators/instances/list_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/theme_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/theme_mode_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/widgetbook_category_instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';

/// An instance for Widgetbook
class WidgetbookInstance extends Instance {
  /// Creates a new instance of [WidgetbookInstance]
  WidgetbookInstance(
      {required AppInfoInstance appInfoInstance,
      required List<WidgetbookCategoryInstance> categories,
      ThemeInstance? lightThemeInstance,
      ThemeInstance? darkThemeInstance,
      ThemeModeInstance? defaultThemeInstance,
      List<DeviceInstance> devices = const <DeviceInstance>[]})
      : super(
          name: 'Widgetbook',
          properties: [
            Property(key: 'appInfo', instance: appInfoInstance),
            if (lightThemeInstance != null)
              Property(key: 'lightTheme', instance: lightThemeInstance),
            if (darkThemeInstance != null)
              Property(key: 'darkTheme', instance: darkThemeInstance),
            if (defaultThemeInstance != null)
              Property(key: 'defaultTheme', instance: defaultThemeInstance),
            if (devices.isNotEmpty)
              Property(
                key: 'devices',
                instance: ListInstance(instances: devices),
              ),
            Property(
              key: 'categories',
              instance: ListInstance(instances: categories),
            ),
          ],
        );
}

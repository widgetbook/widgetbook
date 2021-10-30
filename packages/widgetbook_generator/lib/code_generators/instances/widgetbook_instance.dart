import 'package:widgetbook_generator/code_generators/instances/app_info_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/category_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/device_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/instance.dart';
import 'package:widgetbook_generator/code_generators/instances/list_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/theme_instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';

class WidgetbookInstance extends Instance {
  WidgetbookInstance({
    required AppInfoInstance appInfoInstance,
    required List<CategoryInstance> categories,
    ThemeInstance? lightThemeInstance,
    ThemeInstance? darkThemeInstance,
    List<DeviceInstance> devices = const <DeviceInstance>[],
  }) : super(
          name: 'Widgetbook',
          properties: [
            Property(key: 'appInfo', instance: appInfoInstance),
            if (lightThemeInstance != null)
              Property(key: 'lightTheme', instance: lightThemeInstance),
            if (darkThemeInstance != null)
              Property(key: 'darkTheme', instance: darkThemeInstance),
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

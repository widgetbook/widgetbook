import 'package:widgetbook_generator/code_generators/instances/app_info_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/device_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/double_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/frame_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/instance.dart';
import 'package:widgetbook_generator/code_generators/instances/list_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/theme_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/theme_mode_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/variable_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/widgetbook_category_instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';

/// An instance for Widgetbook
class WidgetbookInstance extends Instance {
  /// Creates a new instance of [WidgetbookInstance]
  WidgetbookInstance({
    required AppInfoInstance appInfoInstance,
    required List<WidgetbookCategoryInstance> categories,
    required List<ThemeInstance> themes,
    List<DeviceInstance> devices = const <DeviceInstance>[],
    List<FrameInstance> frames = const <FrameInstance>[],
    List<DoubleInstance> textScaleFactors = const <DoubleInstance>[],
    VariableInstance? locales,
  }) : super(
          name: 'Widgetbook',
          properties: [
            Property(key: 'appInfo', instance: appInfoInstance),
            if (locales != null)
              Property(key: 'supportedLocales', instance: locales),
            Property(key: 'themes', instance: ListInstance(instances: themes)),
            if (devices.isNotEmpty)
              Property(
                key: 'devices',
                instance: ListInstance(instances: devices),
              ),
            if (frames.isNotEmpty)
              Property(
                key: 'frames',
                instance: ListInstance(instances: frames),
              ),
            if (textScaleFactors.isNotEmpty)
              Property(
                key: 'textScaleFactors',
                instance: ListInstance(instances: textScaleFactors),
              ),
            Property(
              key: 'categories',
              instance: ListInstance(instances: categories),
            ),
          ],
        );
}

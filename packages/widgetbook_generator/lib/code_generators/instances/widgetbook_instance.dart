import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_generator/code_generators/instances/app_info_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/device_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/double_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/frame_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/function_call_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/instance.dart';
import 'package:widgetbook_generator/code_generators/instances/list_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/theme_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/variable_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/widgetbook_category_instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';
import 'package:widgetbook_generator/models/widgetbook_theme_data.dart';
import 'package:widgetbook_generator/models/widgetbook_theme_type_data.dart';

/// An instance for Widgetbook
class WidgetbookInstance extends Instance {
  /// Creates a new instance of [WidgetbookInstance]
  WidgetbookInstance({
    required AppInfoInstance appInfoInstance,
    required WidgetbookConstructor constructor,
    required List<WidgetbookCategoryInstance> categories,
    required List<ThemeInstance> themes,
    String? type,
    List<DeviceInstance> devices = const <DeviceInstance>[],
    List<FrameInstance> frames = const <FrameInstance>[],
    List<DoubleInstance> textScaleFactors = const <DoubleInstance>[],
    VariableInstance? locales,
    VariableInstance? deviceFrameBuilder,
    VariableInstance? localizationBuilder,
    VariableInstance? scaffoldBuilder,
    VariableInstance? useCaseBuilder,
    FunctionCallInstance? themeBuilder,
  }) : super(
          name: 'Widgetbook',
          namedConstructor: constructor.toCode,
          genericParameters: type != null ? [type] : [],
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
            if (deviceFrameBuilder != null)
              Property(
                key: 'deviceFrameBuilder',
                instance: deviceFrameBuilder,
              ),
            if (localizationBuilder != null)
              Property(
                key: 'localizationBuilder',
                instance: localizationBuilder,
              ),
            if (scaffoldBuilder != null)
              Property(
                key: 'scaffoldBuilder',
                instance: scaffoldBuilder,
              ),
            if (useCaseBuilder != null)
              Property(
                key: 'useCaseBuilder',
                instance: useCaseBuilder,
              ),
            if (themeBuilder != null)
              Property(
                key: 'themeBuilder',
                instance: themeBuilder,
              )
          ],
        );
}

import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_generator/code_generators/instances/app_info_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/device_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/double_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/frame_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/function_call_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/theme_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/variable_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/widgetbook_category_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/widgetbook_instance.dart';
import 'package:widgetbook_generator/models/widgetbook_device_frame_data.dart';
import 'package:widgetbook_generator/models/widgetbook_locales_data.dart';
import 'package:widgetbook_generator/models/widgetbook_localization_builder_data.dart';
import 'package:widgetbook_generator/models/widgetbook_localizations_delegates_data.dart';
import 'package:widgetbook_generator/models/widgetbook_scaffold_builder_data.dart';
import 'package:widgetbook_generator/models/widgetbook_theme_builder_data.dart';
import 'package:widgetbook_generator/models/widgetbook_theme_data.dart';
import 'package:widgetbook_generator/models/widgetbook_theme_type_data.dart';
import 'package:widgetbook_generator/models/widgetbook_use_case_builder_data.dart';
import 'package:widgetbook_generator/models/widgetbook_use_case_data.dart';
import 'package:widgetbook_generator/services/tree_service.dart';

/// Generates the code of the Widgetbook
String generateWidgetbook({
  required String name,
  required WidgetbookConstructor constructor,
  required List<WidgetbookUseCaseData> useCases,
  required List<Device> devices,
  required List<WidgetbookFrame> frames,
  required List<double> textScaleFactors,
  required bool foldersExpanded,
  required bool widgetsExpanded,
  WidgetbookLocalesData? localesData,
  WidgetbookLocalizationsDelegatesData? localizationDelegatesData,
  WidgetbookThemeData? widgetbookThemeData,
  WidgetbookThemeTypeData? themeTypeData,
  required List<WidgetbookThemeData> themes,
  WidgetbookDeviceFrameData? deviceFrameBuilder,
  WidgetbookLocalizationBuilderData? localizationBuilder,
  WidgetbookScaffoldBuilderData? scaffoldBuilder,
  WidgetbookThemeBuilderData? themeBuilder,
  WidgetbookUseCaseBuilderData? useCaseBuilder,
}) {
  final category =
      _generateCategoryInstance(useCases, foldersExpanded, widgetsExpanded);
  final widgetbookInstanceCode = WidgetbookInstance(
    constructor: constructor,
    appInfoInstance: AppInfoInstance(name: name),
    themes: themes.map((theme) => ThemeInstance(theme: theme)).toList(),
    devices: devices.map((device) => DeviceInstance(device: device)).toList(),
    frames: frames.map((frame) => FrameInstance(frame: frame)).toList(),
    textScaleFactors: textScaleFactors.map(DoubleInstance.value).toList(),
    categories: [
      category,
    ],
    type: themeTypeData?.name,
    locales: localesData != null
        ? VariableInstance(variableIdentifier: localesData.name)
        : null,
    localizationDelegates: localizationDelegatesData != null
        ? VariableInstance(variableIdentifier: localizationDelegatesData.name)
        : null,
    deviceFrameBuilder: deviceFrameBuilder != null
        ? VariableInstance(variableIdentifier: deviceFrameBuilder.name)
        : null,
    localizationBuilder: localizationBuilder != null
        ? VariableInstance(variableIdentifier: localizationBuilder.name)
        : null,
    scaffoldBuilder: scaffoldBuilder != null
        ? VariableInstance(variableIdentifier: scaffoldBuilder.name)
        : null,
    themeBuilder: themeBuilder != null
        ? FunctionCallInstance(name: themeBuilder.name)
        : null,
    useCaseBuilder: useCaseBuilder != null
        ? VariableInstance(variableIdentifier: useCaseBuilder.name)
        : null,
  ).toCode();

  return '''
class HotReload extends StatelessWidget {
  const HotReload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return $widgetbookInstanceCode;
  }
}
  ''';
}

WidgetbookCategoryInstance _generateCategoryInstance(
  List<WidgetbookUseCaseData> useCases,
  bool foldersExpanded,
  bool widgetsExpanded,
) {
  final service = TreeService(foldersExpanded, widgetsExpanded);

  for (final useCase in useCases) {
    final folder = service.addFolderByImport(useCase.componentImportStatement);
    service.addStoryToFolder(folder, useCase);
  }

  return WidgetbookCategoryInstance(
    name: 'use cases',
    folders: service.folders.values.toList(),
    widgets: service.rootFolder.widgets.values.toList(),
  );
}

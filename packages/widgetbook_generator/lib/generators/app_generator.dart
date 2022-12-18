import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_generator/code_generators/instances/addons/addons.dart';
import 'package:widgetbook_generator/code_generators/instances/app_info_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/variable_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/widgetbook_category_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/widgetbook_instance.dart';
import 'package:widgetbook_generator/models/widgetbook_app_builder_data.dart';
import 'package:widgetbook_generator/models/widgetbook_locales_data.dart';
import 'package:widgetbook_generator/models/widgetbook_localizations_delegates_data.dart';
import 'package:widgetbook_generator/models/widgetbook_theme_data.dart';
import 'package:widgetbook_generator/models/widgetbook_theme_type_data.dart';
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
  WidgetbookAppBuilderData? appBuilder,
}) {
  final category =
      _generateCategoryInstance(useCases, foldersExpanded, widgetsExpanded);

  final addons = <AddOnInstance>[];
  if (constructor == WidgetbookConstructor.material) {
    addons.add(MaterialThemeAddonInstance(themes: themes));
  }

  addons.add(TextScaleAddonInstance(textScales: textScaleFactors));
  if (localesData != null && localizationDelegatesData != null) {
    addons.add(
      LocalizationAddonInstance(
        localesData: localesData,
        localizationDelegatesData: localizationDelegatesData,
      ),
    );
  }
  addons.add(FrameAddonInstance(devices: devices));

  final widgetbookInstanceCode = WidgetbookInstance(
    constructor: constructor,
    addons: addons,
    appInfoInstance: AppInfoInstance(name: name),
    categories: [
      category,
    ],
    type: themeTypeData?.name,
    appBuilder: appBuilder != null
        ? VariableInstance(variableIdentifier: appBuilder.name)
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

import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_generator/code_generators/instances/instance.dart';
import 'package:widgetbook_generator/code_generators/instances/variable_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/widgetbook_folder_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/widgetbook_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/widgetbook_widget_instance.dart';
import 'package:widgetbook_generator/models/widgetbook_app_builder_data.dart';
import 'package:widgetbook_generator/models/widgetbook_use_case_data.dart';
import 'package:widgetbook_generator/services/tree_service.dart';

/// Generates the code of the Widgetbook
String generateWidgetbook({
  required Constructor constructor,
  required List<WidgetbookUseCaseData> useCases,
  required bool foldersExpanded,
  required bool widgetsExpanded,
  WidgetbookAppBuilderData? appBuilder,
}) {
  final directories =
      _generateDirectoriesInstances(useCases, foldersExpanded, widgetsExpanded);

  final widgetbookInstanceCode = WidgetbookInstance(
    constructor: constructor,
    directories: directories,
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

List<Instance> _generateDirectoriesInstances(
  List<WidgetbookUseCaseData> useCases,
  bool foldersExpanded,
  bool widgetsExpanded,
) {
  final service = TreeService(
    foldersExpanded: foldersExpanded,
    widgetsExpanded: widgetsExpanded,
  );

  for (final useCase in useCases) {
    final folder = service.addFolderByImport(useCase.componentImportStatement);
    service.addStoryToFolder(folder, useCase);
  }

  return [
    ...service.folders.values.map(
      (e) => WidgetbookFolderInstance(folder: e),
    ),
    ...service.rootFolder.widgets.values.map(
      (e) => WidgetbookComponentInstance(
        name: e.name,
        stories: e.stories,
      ),
    ),
  ];
}

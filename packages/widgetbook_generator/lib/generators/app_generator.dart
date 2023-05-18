import '../code_generators/instances/instance.dart';
import '../code_generators/instances/list_instance.dart';
import '../code_generators/instances/widgetbook_folder_instance.dart';
import '../code_generators/instances/widgetbook_widget_instance.dart';
import '../models/widgetbook_use_case_data.dart';
import '../services/tree_service.dart';

/// Generates the code of the Widgetbook
String generateWidgetbook({
  required List<WidgetbookUseCaseData> useCases,
  required bool foldersExpanded,
  required bool widgetsExpanded,
}) {
  final directories = _generateDirectoriesInstances(
    useCases,
    foldersExpanded,
    widgetsExpanded,
  );

  final instance = ListInstance(
    instances: directories,
  ).toCode();

  return 'final directories = $instance;';
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

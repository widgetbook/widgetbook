import 'package:widgetbook_generator/code_generators/instances/app_info_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/device_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/folder_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/list_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/widget_element_instance.dart';
import 'package:widgetbook_generator/models/widgetbook_story_data.dart';
import 'package:widgetbook_generator/models/widgetbook_theme_data.dart';
import 'package:widgetbook_generator/services/tree_service.dart';
import 'package:widgetbook_models/widgetbook_models.dart';

/// Generates the code of the Widgetbook
String generateWidgetbook({
  required String name,
  required List<WidgetbookStoryData> stories,
  required List<Device> devices,
  WidgetbookThemeData? lightTheme,
  WidgetbookThemeData? darkTheme,
}) {
  return '''
class HotReload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Widgetbook(
      appInfo: ${_generateAppInfo(name: name)},
      lightTheme: ${_generateThemeDataValue(lightTheme)},
      darkTheme: ${_generateThemeDataValue(darkTheme)},
      categories: ${_generateStoryValues(stories)},
      ${_generateDevicesLine(devices)}
    );
  }
}
''';
}

ListInstance<DeviceInstance> _generateDevicesLine(List<Device> devices) {
  return ListInstance(
    instances: devices
        .map(
          (device) => DeviceInstance(device: device),
        )
        .toList(),
  );
}

String _generateStoryValues(List<WidgetbookStoryData> stories) {
  final service = TreeService();

  for (final story in stories) {
    final folder = service.addFolderByImport(story.importStatement);
    service.addStoryToFolder(folder, story);
  }

  final foldersCode = service.folders.values.map(_generateFolder).toList();
  final code =
      "[Category(name: 'stories', folders: [${foldersCode.join(',')}],),]";
  return code;
}

WidgetElementInstance _generateWidget(Widget widget) {
  return WidgetElementInstance(
    name: widget.name,
    stories: widget.stories,
  );
}

FolderInstance _generateFolder(Folder folder) {
  return FolderInstance(folder: folder);
}

String _generateAppInfo({
  required String name,
}) {
  return AppInfoInstance(name: name).toCode();
}

String _generateThemeDataValue(WidgetbookThemeData? themeData) {
  return themeData == null ? 'null' : '${themeData.name}()';
}

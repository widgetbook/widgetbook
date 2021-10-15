import 'dart:collection';

import 'package:widgetbook_generator/models/widgetbook_story_data.dart';
import 'package:widgetbook_generator/models/widgetbook_theme_data.dart';
import 'package:widgetbook_generator/services/tree_service.dart';

String generateWidgetbook({
  required String name,
  required List<WidgetbookStoryData> stories,
  WidgetbookThemeData? lightTheme,
  WidgetbookThemeData? darkTheme,
}) {
  return '''
class HotReload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Widgetbook(
      appInfo: ${generateAppInfo(name: name)},
      lightTheme: ${generateThemeDataValue(lightTheme)},
      darkTheme: ${generateThemeDataValue(darkTheme)},
      categories: ${generateStoryValues(stories)},
    );
  }
}
''';
}

String generateStoryValues(List<WidgetbookStoryData> stories) {
  var regExp = RegExp('\/.+(?=\/)', caseSensitive: false);
  var service = TreeService();

  for (final story in stories) {
    var folder = service.addFolderByImport(story.importStatement);
    service.addStoryToFolder(folder, story);
  }

  List<String> foldersCode =
      service.folders.values.map(generateFolder).toList();
  String code =
      "[Category(name: 'stories', folders: [${foldersCode.join(',')}],),]";
  return code;
}

String generateStory(WidgetbookStoryData story) {
  return """Story(
  name: '${story.storyName}',
  builder: (context) => ${story.name}(context),
)""";
}

String generateWidget(Widget widget) {
  var stories = widget.stories.map(generateStory).toList();

  return """WidgetElement(
  name: '${widget.name}',
  stories: [${stories.join(',')},],
)""";
}

String generateFolder(Folder folder) {
  List<String> widgetsCode = folder.widgets.values.map(generateWidget).toList();
  if (folder.subFolders.isEmpty) {
    return """Folder(
  name: '${folder.name}', 
  widgets: [${widgetsCode.join(',')},],
)""";
  }

  List<String> foldersCode = folder.subFolders.values
      .map(
        (folder) => generateFolder(folder),
      )
      .toList();

  return """Folder(
  name: '${folder.name}', 
  folders: [${foldersCode.join(',')},],
  widgets: [${widgetsCode.join(',')},],
)""";
}

String generateAppInfo({
  required String name,
}) {
  return "AppInfo(name: '$name')";
}

String generateThemeDataValue(WidgetbookThemeData? themeData) {
  return themeData == null ? 'null' : '${themeData.name}()';
}

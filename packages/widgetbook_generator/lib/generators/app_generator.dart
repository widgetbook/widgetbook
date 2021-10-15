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

    var folders = regExp.allMatches(story.importStatement).toList();

    int t = 0;
  }

  List<String> foldersCode =
      service.folders.values.map(generateFolder).toList();
  String code =
      "[Category(name: 'stories', folders: [${foldersCode.join(',')}],),]";
  return code;
}

String generateFolder(Folder folder) {
  if (folder.subFolders.isEmpty) {
    return "Folder(name: '${folder.name}')";
  }

  List<String> foldersCode = folder.subFolders.values
      .map(
        (folder) => generateFolder(folder),
      )
      .toList();

  return "Folder(name: '${folder.name}', folders: [${foldersCode.join(',')}],)";
}

String generateAppInfo({
  required String name,
}) {
  return "AppInfo(name: '$name')";
}

String generateThemeDataValue(WidgetbookThemeData? themeData) {
  return themeData == null ? 'null' : '${themeData.name}()';
}

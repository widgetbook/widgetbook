import 'dart:collection';

import 'package:widgetbook_generator/models/widgetbook_story_data.dart';

class Widget {
  final String name;
  List<WidgetbookStoryData> stories = <WidgetbookStoryData>[];

  Widget(this.name);
}

class Folder {
  final String name;
  Map<String, Folder> subFolders = HashMap();
  Map<String, Widget> widgets = HashMap();

  Folder({
    required this.name,
  });
}

class TreeService {
  Map<String, Folder> folders = HashMap();
  // TODO This is a bit weird but (likely) works
  Folder rootFolder = Folder(name: 'root');

  // Returns the lowest folder in the tree
  // might return null if the file is located in lib folder
  Folder? addFolderByImport(
    String import,
  ) {
    var elements = import.split('/').toList();
    elements = elements.skip(1).toList();
    // TODO improve
    // This skips the last element
    elements = elements.reversed.skip(1).toList().reversed.toList();
    return addFolder(null, elements);
  }

  addStoryToFolder(
    Folder? folder,
    WidgetbookStoryData story,
  ) {
    var widgetName = story.widgetName;

    folder ??= rootFolder;

    var widgets = folder.widgets;
    if (!widgets.containsKey(widgetName)) {
      widgets.putIfAbsent(
        widgetName,
        () => Widget(widgetName),
      );
    }

    // TODO do we need to check if a story with that name already exist?
    // if might happen by copy and pasting that stories are dublicated.
    widgets[widgetName]!.stories.add(story);
  }

  Folder? addFolder(Folder? folder, List<String> paths) {
    if (paths.isEmpty) {
      return folder;
    }

    var folderName = paths.first;
    var subFolders = paths.skip(1).toList();

    if (folder == null) {
      if (!folders.containsKey(folderName)) {
        folders.putIfAbsent(
          folderName,
          () => Folder(name: folderName),
        );
      }

      return addFolder(
        folders[folderName],
        subFolders,
      );
    }
    // TODO redundant code. needs refactoring.
    else {
      if (!folder.subFolders.containsKey(folderName)) {
        folder.subFolders.putIfAbsent(
          folderName,
          () => Folder(name: folderName),
        );
      }

      return addFolder(
        folder.subFolders[folderName],
        subFolders,
      );
    }
  }
}

import 'dart:collection';
import 'package:meta/meta.dart';
import 'package:widgetbook_generator/models/widgetbook_story_data.dart';

class Widget {
  Widget(this.name);

  final String name;
  List<WidgetbookStoryData> stories = <WidgetbookStoryData>[];
}

@immutable
class Folder {
  Folder({
    required this.name,
  });

  final String name;
  final Map<String, Folder> subFolders = HashMap();
  final Map<String, Widget> widgets = HashMap();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Folder && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
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
    if (elements.isNotEmpty && elements[0] == 'src') {
      elements = elements.skip(1).toList();
    }

    return addFolder(null, elements);
  }

  void addStoryToFolder(
    Folder? folder,
    WidgetbookStoryData story,
  ) {
    final widgetName = story.widgetName;

    folder ??= rootFolder;

    final widgets = folder.widgets;
    if (!widgets.containsKey(widgetName)) {
      widgets.putIfAbsent(
        widgetName,
        () => Widget(widgetName),
      );
    }

    // TODO do we need to check if a story with that name already exist?
    // it might happen by copy and pasting that stories are duplicated.
    widgets[widgetName]!.stories.add(story);
  }

  Folder? addFolder(Folder? folder, List<String> paths) {
    if (paths.isEmpty) {
      return folder;
    }

    final folderName = paths.first;
    final subFolders = paths.skip(1).toList();

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

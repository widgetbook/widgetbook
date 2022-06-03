import 'dart:collection';

import 'package:meta/meta.dart';
import 'package:widgetbook_generator/models/widgetbook_use_case_data.dart';

class Widget {
  Widget(
    this.name, {
    this.isExpanded = false,
  });

  final String name;
  final bool isExpanded;
  List<WidgetbookUseCaseData> stories = <WidgetbookUseCaseData>[];
}

@immutable
class Folder {
  Folder({
    required this.name,
    this.isExpanded = false,
  });

  final String name;
  final bool isExpanded;
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
  TreeService([this.foldersExpanded = false, this.widgetsExpanded = false])
      : rootFolder = Folder(name: 'root', isExpanded: foldersExpanded);

  final bool foldersExpanded;
  final bool widgetsExpanded;

  Map<String, Folder> folders = HashMap();
  // TODO This is a bit weird but (likely) works
  final Folder rootFolder;

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
    WidgetbookUseCaseData useCase,
  ) {
    final widgetName = useCase.componentName;

    folder ??= rootFolder;

    final widgets = folder.widgets;
    if (!widgets.containsKey(widgetName)) {
      widgets.putIfAbsent(
        widgetName,
        () => Widget(widgetName, isExpanded: widgetsExpanded),
      );
    }

    // TODO do we need to check if a story with that name already exist?
    // it might happen by copy and pasting that stories are duplicated.
    widgets[widgetName]!.stories.add(useCase);
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
          () => Folder(
            name: folderName,
            isExpanded: foldersExpanded,
          ),
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
          () => Folder(
            name: folderName,
            isExpanded: foldersExpanded,
          ),
        );
      }

      return addFolder(
        folder.subFolders[folderName],
        subFolders,
      );
    }
  }
}

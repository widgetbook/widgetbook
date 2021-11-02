import 'package:widgetbook/widgetbook.dart';

/// Helper to navigate the folder tree.
class FolderHelper {
  static List<WidgetbookFolder> getAllFoldersFromCategories(
      List<WidgetbookCategory> categories) {
    final folders = <WidgetbookFolder>[];
    for (final category in categories) {
      folders.addAll(
        getAllFoldersFromCategory(category),
      );
    }
    return folders;
  }

  static List<WidgetbookFolder> getAllFoldersFromCategory(
      WidgetbookCategory category) {
    return getAllFoldersFromFolders(category.folders);
  }

  static List<WidgetbookFolder> getAllFoldersFromFolders(
      List<WidgetbookFolder> folders) {
    final folderList = <WidgetbookFolder>[];
    for (final folder in folders) {
      folderList.addAll(
        getAllFoldersFromFolder(folder),
      );
    }
    return folderList;
  }

  static List<WidgetbookFolder> getAllFoldersFromFolder(
      WidgetbookFolder folder) {
    final folderList = List<WidgetbookFolder>.from(
      <WidgetbookFolder>[folder],
    )..addAll(
        getAllFoldersFromFolders(folder.folders),
      );
    return folderList;
  }
}

import 'package:widgetbook/widgetbook.dart';

/// Helper to navigate the folder tree.
class FolderHelper {
  static List<Folder> getAllFoldersFromCategories(List<Category> categories) {
    final folders = <Folder>[];
    for (final category in categories) {
      folders.addAll(
        getAllFoldersFromCategory(category),
      );
    }
    return folders;
  }

  static List<Folder> getAllFoldersFromCategory(Category category) {
    return getAllFoldersFromFolders(category.folders);
  }

  static List<Folder> getAllFoldersFromFolders(List<Folder> folders) {
    final folderList = <Folder>[];
    for (final folder in folders) {
      folderList.addAll(
        getAllFoldersFromFolder(folder),
      );
    }
    return folderList;
  }

  static List<Folder> getAllFoldersFromFolder(Folder folder) {
    final folderList = List<Folder>.from(
      <Folder>[folder],
    )..addAll(
        getAllFoldersFromFolders(folder.folders),
      );
    return folderList;
  }
}

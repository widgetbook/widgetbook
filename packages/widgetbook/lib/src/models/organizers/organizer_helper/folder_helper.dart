import 'package:widgetbook/widgetbook.dart';

/// Helper to navigate the folder tree.
class FolderHelper {
  static List<Folder> getAllFoldersFromCategories(List<Category> categories) {
    List<Folder> folders = [];
    for (Category category in categories) {
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
    List<Folder> folderList = [];
    for (Folder folder in folders) {
      folderList.addAll(
        getAllFoldersFromFolder(folder),
      );
    }
    return folderList;
  }

  static List<Folder> getAllFoldersFromFolder(Folder folder) {
    List<Folder> folderList = List<Folder>.from(
      [folder],
    );
    folderList.addAll(
      getAllFoldersFromFolders(folder.folders),
    );
    return folderList;
  }
}

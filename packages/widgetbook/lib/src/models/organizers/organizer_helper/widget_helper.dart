import 'package:widgetbook/widgetbook.dart';

/// helper to obtain all WidgetElements in the navigation tree.
class WidgetHelper {
  static List<WidgetElement> getAllWidgetElementsFromCategories(
      List<Category> categories) {
    final widgets = <WidgetElement>[];
    for (final category in categories) {
      widgets.addAll(
        getAllWidgetElementsFromCategory(category),
      );
    }
    return widgets;
  }

  static List<WidgetElement> getAllWidgetElementsFromCategory(
      Category category) {
    final widgetList = List<WidgetElement>.from(
      category.widgets,
    )..addAll(
        getAllWidgetElementsFromFolders(category.folders),
      );
    return widgetList;
  }

  static List<WidgetElement> getAllWidgetElementsFromFolders(
      List<Folder> folders) {
    final widgetList = <WidgetElement>[];
    for (final folder in folders) {
      widgetList.addAll(
        getAllWidgetElementsFromFolder(folder),
      );
    }
    return widgetList;
  }

  static List<WidgetElement> getAllWidgetElementsFromFolder(Folder folder) {
    final widgetList = List<WidgetElement>.from(folder.widgets)
      ..addAll(
        getAllWidgetElementsFromFolders(folder.folders),
      );
    return widgetList;
  }
}

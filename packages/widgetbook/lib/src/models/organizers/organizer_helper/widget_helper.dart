import 'package:widgetbook/widgetbook.dart';

class WidgetHelper {
  static List<WidgetElement> getAllWidgetElementsFromCategories(
      List<Category> categories) {
    List<WidgetElement> widgets = [];
    for (Category category in categories) {
      widgets.addAll(
        getAllWidgetElementsFromCategory(category),
      );
    }
    return widgets;
  }

  static List<WidgetElement> getAllWidgetElementsFromCategory(
      Category category) {
    List<WidgetElement> widgetList = List<WidgetElement>.from(
      category.widgets,
    );
    widgetList.addAll(
      getAllWidgetElementsFromFolders(category.folders),
    );
    return widgetList;
  }

  static List<WidgetElement> getAllWidgetElementsFromFolders(
      List<Folder> folders) {
    List<WidgetElement> widgetList = [];
    for (Folder folder in folders) {
      widgetList.addAll(
        getAllWidgetElementsFromFolder(folder),
      );
    }
    return widgetList;
  }

  static List<WidgetElement> getAllWidgetElementsFromFolder(Folder folder) {
    List<WidgetElement> widgetList = List<WidgetElement>.from(folder.widgets);
    widgetList.addAll(
      getAllWidgetElementsFromFolders(folder.folders),
    );
    return widgetList;
  }
}

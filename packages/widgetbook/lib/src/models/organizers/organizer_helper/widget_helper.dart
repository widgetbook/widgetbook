import 'package:widgetbook/widgetbook.dart';

/// helper to obtain all WidgetElements in the navigation tree.
class WidgetHelper {
  static List<WidgetbookComponent> getAllWidgetElementsFromCategories(
      List<WidgetbookCategory> categories) {
    final widgets = <WidgetbookComponent>[];
    for (final category in categories) {
      widgets.addAll(
        getAllWidgetElementsFromCategory(category),
      );
    }
    return widgets;
  }

  static List<WidgetbookComponent> getAllWidgetElementsFromCategory(
      WidgetbookCategory category) {
    final widgetList = List<WidgetbookComponent>.from(
      category.widgets,
    )..addAll(
        getAllWidgetElementsFromFolders(category.folders),
      );
    return widgetList;
  }

  static List<WidgetbookComponent> getAllWidgetElementsFromFolders(
      List<WidgetbookFolder> folders) {
    final widgetList = <WidgetbookComponent>[];
    for (final folder in folders) {
      widgetList.addAll(
        getAllWidgetElementsFromFolder(folder),
      );
    }
    return widgetList;
  }

  static List<WidgetbookComponent> getAllWidgetElementsFromFolder(
      WidgetbookFolder folder) {
    final widgetList = List<WidgetbookComponent>.from(folder.widgets)
      ..addAll(
        getAllWidgetElementsFromFolders(folder.folders),
      );
    return widgetList;
  }
}

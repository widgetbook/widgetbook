import 'package:widgetbook/widgetbook.dart';

/// helper to obtain all WidgetElements in the navigation tree.
class WidgetHelper {
  static List<WidgetbookWidget> getAllWidgetElementsFromCategories(
      List<WidgetbookCategory> categories) {
    final widgets = <WidgetbookWidget>[];
    for (final category in categories) {
      widgets.addAll(
        getAllWidgetElementsFromCategory(category),
      );
    }
    return widgets;
  }

  static List<WidgetbookWidget> getAllWidgetElementsFromCategory(
      WidgetbookCategory category) {
    final widgetList = List<WidgetbookWidget>.from(
      category.widgets,
    )..addAll(
        getAllWidgetElementsFromFolders(category.folders),
      );
    return widgetList;
  }

  static List<WidgetbookWidget> getAllWidgetElementsFromFolders(
      List<WidgetbookFolder> folders) {
    final widgetList = <WidgetbookWidget>[];
    for (final folder in folders) {
      widgetList.addAll(
        getAllWidgetElementsFromFolder(folder),
      );
    }
    return widgetList;
  }

  static List<WidgetbookWidget> getAllWidgetElementsFromFolder(
      WidgetbookFolder folder) {
    final widgetList = List<WidgetbookWidget>.from(folder.widgets)
      ..addAll(
        getAllWidgetElementsFromFolders(folder.folders),
      );
    return widgetList;
  }
}

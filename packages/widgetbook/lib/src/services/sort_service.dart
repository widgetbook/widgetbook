import 'package:widgetbook/src/models/models.dart';
import 'package:widgetbook/src/models/organizers/organizer_comparators.dart';

/* Sorting algorithm:
1. Categories
2. Folders
3. Widgets
Note, that widget's use cases are ignored.
 */
class SortService {
  const SortService();

  /// Recursively sorts the [WidgetbookCategory] tree.
  List<WidgetbookCategory> sort(
    List<WidgetbookCategory> categories,
    Sorting sorting,
  ) {
    final comparator = sorting == Sorting.asc
        ? OrganizerComparators.byNameAsc
        : OrganizerComparators.byNameDesc;

    return _doSort(categories, comparator);
  }

  List<WidgetbookCategory> _doSort(
    List<WidgetbookCategory> categories,
    Comparator<Organizer> comparator,
  ) {
    return categories
        .map((category) => sortCategory(category, comparator))
        .toList()
      ..sort(comparator);
  }

  /// Recursively sorts folders and widgets of given [category]. Returns a new
  /// instance of [WidgetbookCategory].
  WidgetbookCategory sortCategory(
    WidgetbookCategory category,
    Comparator<Organizer> comparator,
  ) {
    final folders = category.folders
        .map((folder) => sortFolder(folder, comparator))
        .toList()
      ..sort(comparator);

    final widgets = category.widgets
        .map((widget) => _sortWidget(widget, comparator))
        .toList()
      ..sort(comparator);

    return WidgetbookCategory(
      name: category.name,
      isExpanded: category.isExpanded,
      folders: folders,
      widgets: widgets,
    );
  }

  /// Recursively sorts folders and widgets of given [folder]. Returns a new
  /// instance of [WidgetbookFolder].
  WidgetbookFolder sortFolder(
    WidgetbookFolder folder,
    Comparator<Organizer> comparator,
  ) {
    final folders = folder.folders
        .map((folder) => sortFolder(folder, comparator))
        .toList()
      ..sort(comparator);

    final widgets = folder.widgets
        .map((widget) => _sortWidget(widget, comparator))
        .toList()
      ..sort(comparator);

    return WidgetbookFolder(
      name: folder.name,
      isExpanded: folder.isExpanded,
      folders: folders,
      widgets: widgets,
    );
  }

  WidgetbookComponent _sortWidget(
    WidgetbookComponent widget,
    Comparator<Organizer> comparator,
  ) {
    return WidgetbookComponent(
      name: widget.name,
      isExpanded: widget.isExpanded,
      useCases: widget.useCases,
    );
  }
}

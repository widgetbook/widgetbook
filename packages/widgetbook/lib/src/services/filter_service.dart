import 'package:widgetbook/src/models/models.dart';

class FilterService {
  const FilterService();

  List<WidgetbookCategory> filter(
    String searchTerm,
    List<WidgetbookCategory> categories,
  ) {
    return _filterCategories(
      RegExp(
        searchTerm,
        caseSensitive: false,
      ),
      categories,
    );
  }

  List<WidgetbookCategory> _filterCategories(
    RegExp regExp,
    List<WidgetbookCategory> categories,
  ) {
    final matchingOrganizers = <WidgetbookCategory>[];
    for (final category in categories) {
      final result = _filterOrganizer(regExp, category) as WidgetbookCategory?;
      if (_isMatch(result)) {
        matchingOrganizers.add(result!);
      }
    }
    return matchingOrganizers;
  }

  ExpandableOrganizer? _filterOrganizer(
      RegExp regExp, ExpandableOrganizer organizer) {
    if (organizer.name.contains(regExp)) {
      return organizer;
    }

    final matchingFolders = <WidgetbookFolder>[];
    for (final subOrganizer in organizer.folders) {
      final result = _filterOrganizer(regExp, subOrganizer);
      if (_isMatch(result)) {
        matchingFolders.add(result! as WidgetbookFolder);
      }
    }

    final matchingWidgets = <WidgetbookComponent>[];
    for (final subOrganizer in organizer.widgets) {
      final result = _filterOrganizer(regExp, subOrganizer);
      if (_isMatch(result)) {
        matchingWidgets.add(result! as WidgetbookComponent);
      }
    }

    if (matchingFolders.isNotEmpty || matchingWidgets.isNotEmpty) {
      return _createFilteredSubtree(
        organizer,
        matchingFolders,
        matchingWidgets,
      );
    }

    return null;
  }

  ExpandableOrganizer _createFilteredSubtree(
    ExpandableOrganizer organizer,
    List<WidgetbookFolder> folders,
    List<WidgetbookComponent> widgets,
  ) {
    if (organizer is WidgetbookCategory) {
      return WidgetbookCategory(
        name: organizer.name,
        widgets: widgets,
        folders: folders,
      );
    }

    // otherwise it can only be a folder
    return WidgetbookFolder(
      name: organizer.name,
      widgets: widgets,
      folders: folders,
      isExpanded: organizer.isExpanded,
    );
  }

  bool _isMatch(ExpandableOrganizer? organizer) {
    return organizer != null;
  }
}

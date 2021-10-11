import 'package:widgetbook/src/models/models.dart';

class FilterService {
  const FilterService();

  List<Category> filter(
    String searchTerm,
    List<Category> categories,
  ) {
    return _filterCategories(
      RegExp(searchTerm),
      categories,
    );
  }

  List<Category> _filterCategories(
    RegExp regExp,
    List<Category> categories,
  ) {
    final matchingOrganizers = <Category>[];
    for (final category in categories) {
      final result = _filterOrganizer(regExp, category) as Category?;
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

    final matchingFolders = <Folder>[];
    for (final subOrganizer in organizer.folders) {
      final result = _filterOrganizer(regExp, subOrganizer);
      if (_isMatch(result)) {
        matchingFolders.add(result! as Folder);
      }
    }

    final matchingWidgets = <WidgetElement>[];
    for (final subOrganizer in organizer.widgets) {
      final result = _filterOrganizer(regExp, subOrganizer);
      if (_isMatch(result)) {
        matchingWidgets.add(result! as WidgetElement);
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
    List<Folder> folders,
    List<WidgetElement> widgets,
  ) {
    if (organizer is Category) {
      return Category(
        name: organizer.name,
        widgets: widgets,
        folders: folders,
      );
    }

    // otherwise it can only be a folder
    return Folder(
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

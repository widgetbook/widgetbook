import 'package:widgetbook/src/models/models.dart';
import 'package:widgetbook/src/models/organizers/organizer_helper/organizer_helper.dart';
import 'package:widgetbook/src/navigation/organizer_state.dart';
import 'package:widgetbook/src/repositories/story_repository.dart';
import 'package:widgetbook/src/services/filter_service.dart';
import 'package:widgetbook/src/services/sort_service.dart';
import 'package:widgetbook/src/state_change_notifier.dart';

class OrganizerProvider extends StateChangeNotifier<OrganizerState> {
  OrganizerProvider({
    required OrganizerState state,
    required this.storyRepository,
    this.filterService = const FilterService(),
    this.sortService = const SortService(),
  }) : super(state: state);

  final StoryRepository storyRepository;
  final FilterService filterService;
  final SortService sortService;

  void openStory(WidgetbookUseCase? story) {
    if (story == null) {
      return;
    }
    var currentOrganizer = story.parent as ExpandableOrganizer?;
    while (currentOrganizer != null) {
      currentOrganizer.isExpanded = true;
      currentOrganizer = currentOrganizer.parent as ExpandableOrganizer?;
    }
  }

  void _updateFolders(List<WidgetbookCategory> categories) {
    final oldFolders = FolderHelper.getAllFoldersFromCategories(
      state.initialCategories,
    );
    final newFolders = FolderHelper.getAllFoldersFromCategories(
      categories,
    );
    final oldFolderMap = {
      for (var e in oldFolders) e.path: e,
    };

    for (final folder in newFolders) {
      final path = folder.path;
      if (oldFolderMap.containsKey(path)) {
        folder.isExpanded = oldFolderMap[path]!.isExpanded;
      }
    }
  }

  void _updateWidgets(List<WidgetbookCategory> categories) {
    final oldWidgets = WidgetHelper.getAllWidgetElementsFromCategories(
      state.initialCategories,
    );
    final newWidgets = WidgetHelper.getAllWidgetElementsFromCategories(
      categories,
    );
    final oldFolderMap = {
      for (var e in oldWidgets) e.path: e,
    };

    for (final widget in newWidgets) {
      final path = widget.path;
      if (oldFolderMap.containsKey(path)) {
        widget.isExpanded = oldFolderMap[path]!.isExpanded;
      }
    }
  }

  void hotReload(List<WidgetbookCategory> categories) {
    _updateFolders(categories);
    _updateWidgets(categories);
    state = OrganizerState.initial(categories: categories);

    final stories = StoryHelper.getAllStoriesFromCategories(categories);
    storyRepository
      ..deleteAll()
      ..addAll(stories);
  }

  void resetFilter() {
    _applySortingAndFiltering(
      searchTerm: '',
      sorting: state.sorting,
    );
  }

  void filter(String searchTerm) {
    _applySortingAndFiltering(
      searchTerm: searchTerm,
      sorting: state.sorting,
    );
  }

  void sort(Sorting? sorting) {
    _applySortingAndFiltering(
      searchTerm: state.searchTerm,
      sorting: sorting,
    );
  }

  void resetSort() {
    _applySortingAndFiltering(
      searchTerm: state.searchTerm,
      sorting: null,
    );
  }

  void _applySortingAndFiltering({
    required String searchTerm,
    required Sorting? sorting,
  }) {
    var categories = state.initialCategories;

    if (searchTerm.isNotEmpty) {
      categories = filterService.filter(
        searchTerm,
        categories,
      );
    }

    if (sorting != null) {
      categories = sortService.sort(
        categories,
        sorting,
      );
    }

    state = state.copyWith(
      categories: categories,
      searchTerm: searchTerm,
      sorting: sorting,
    );
  }

  void toggleExpander(ExpandableOrganizer organizer) {
    // Since this is modifying the object directly instead of modifying via
    // copyWith, we need to call notifyListeners and are not emmitting a new
    // state object. The state will be adjusted by adjusted the object.
    organizer.isExpanded = !organizer.isExpanded;
    notifyListeners();
  }

  /// Recursively set the expanded field for an organizer and it's nested widgets.
  /// Does not emit after toggling.
  void _setExpandedRecursive(ExpandableOrganizer organizer, bool value) {
    organizer.isExpanded = value;
    for (final folder in organizer.folders) {
      _setExpandedRecursive(folder, value);
    }
    for (final folder in organizer.widgets) {
      _setExpandedRecursive(folder, value);
    }
  }

  /// Set isExpanded an [ExpandableOrganizer] and its nested organizer to
  /// the `expanded`
  void setExpandedRecursive(
    List<ExpandableOrganizer> organizers, {
    required bool expanded,
  }) {
    // Since this is modifying the object directly instead of modifying via
    // copyWith, we need to call notifyListeners and are not emmitting a new
    // state object. The state will be adjusted by adjusted the object.
    for (final e in organizers) {
      _setExpandedRecursive(e, expanded);
    }

    notifyListeners();
  }
}

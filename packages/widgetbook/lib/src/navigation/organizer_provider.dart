import 'package:widgetbook/src/models/models.dart';
import 'package:widgetbook/src/models/organizers/organizer_helper/organizer_helper.dart';
import 'package:widgetbook/src/navigation/organizer_state.dart';
import 'package:widgetbook/src/repositories/story_repository.dart';
import 'package:widgetbook/src/services/filter_service.dart';
import 'package:widgetbook/src/state_change_notifier.dart';

class OrganizerProvider extends StateChangeNotifier<OrganizerState> {
  OrganizerProvider({
    required OrganizerState state,
    required this.storyRepository,
    this.filterService = const FilterService(),
  }) : super(state: state);

  final StoryRepository storyRepository;
  final FilterService filterService;

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
      state.allCategories,
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
      state.allCategories,
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
    state = OrganizerState.unfiltered(categories: categories);

    final stories = StoryHelper.getAllStoriesFromCategories(categories);
    storyRepository
      ..deleteAll()
      ..addAll(stories);
  }

  void resetFilter() {
    state = OrganizerState.unfiltered(
      categories: state.allCategories,
    );
  }

  void filter(String searchTerm) {
    final categories = filterService.filter(
      searchTerm,
      state.allCategories,
    );

    state = OrganizerState(
      allCategories: state.allCategories,
      filteredCategories: categories,
      searchTerm: searchTerm,
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
      List<ExpandableOrganizer> organizers, bool expanded) {
    // Since this is modifying the object directly instead of modifying via
    // copyWith, we need to call notifyListeners and are not emmitting a new
    // state object. The state will be adjusted by adjusted the object.
    for (final e in organizers) {
      _setExpandedRecursive(e, expanded);
    }

    notifyListeners();
  }
}

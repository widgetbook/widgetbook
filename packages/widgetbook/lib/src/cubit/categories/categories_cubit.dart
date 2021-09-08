import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:widgetbook/src/cubit/canvas/canvas_cubit.dart';
import 'package:widgetbook/src/models/organizers/organizer_helper/organizer_helper.dart';
import 'package:widgetbook/src/models/organizers/organizers.dart';
import 'package:widgetbook/src/repository/story_repository.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<OrganizerState> {
  final CanvasCubit canvasCubit;
  final StoryRepository storyRepository;
  CategoriesCubit({
    required List<Category> categories,
    required this.storyRepository,
    required this.canvasCubit,
  }) : super(
          OrganizerState.unfiltered(
            categories: categories,
          ),
        ) {
    canvasCubit.stream.forEach((CanvasState state) {
      _openStory(state.selectedStory);
    });
  }

  void _openStory(Story? story) {
    if (story == null) {
      return;
    }
    ExpandableOrganizer? currentOrganizer =
        story.parent as ExpandableOrganizer?;
    while (currentOrganizer != null) {
      currentOrganizer.isExpanded = true;
      currentOrganizer = currentOrganizer.parent as ExpandableOrganizer?;
    }
  }

  void _updateFolders(List<Category> categories) {
    var oldFolders = FolderHelper.getAllFoldersFromCategories(
      state.allCategories,
    );
    var newFolders = FolderHelper.getAllFoldersFromCategories(
      categories,
    );
    var oldFolderMap = HashMap<String, Folder>.fromIterable(
      oldFolders,
      key: (k) => k.path,
      value: (v) => v,
    );

    for (var folder in newFolders) {
      var path = folder.path;
      if (oldFolderMap.containsKey(path)) {
        folder.isExpanded = oldFolderMap[path]!.isExpanded;
      }
    }
  }

  void _updateWidgets(List<Category> categories) {
    var oldWidgets = WidgetHelper.getAllWidgetElementsFromCategories(
      state.allCategories,
    );
    var newWidgets = WidgetHelper.getAllWidgetElementsFromCategories(
      categories,
    );
    var oldFolderMap = HashMap<String, WidgetElement>.fromIterable(
      oldWidgets,
      key: (k) => k.path,
      value: (v) => v,
    );

    for (var widget in newWidgets) {
      var path = widget.path;
      if (oldFolderMap.containsKey(path)) {
        widget.isExpanded = oldFolderMap[path]!.isExpanded;
      }
    }
  }

  void update(List<Category> categories) {
    _updateFolders(categories);
    _updateWidgets(categories);
    emit(
      OrganizerState.unfiltered(categories: categories),
    );

    var stories = StoryHelper.getAllStoriesFromCategories(categories);
    storyRepository.deleteAll();
    storyRepository.addAll(stories);
  }

  void resetFilter() {
    emit(
      OrganizerState.unfiltered(
        categories: state.allCategories,
      ),
    );
  }

  void filter(RegExp regExp) {
    var categories = filterCategories(
      regExp,
      state.allCategories,
    );

    emit(
      OrganizerState(
        allCategories: state.allCategories,
        filteredCategories: categories,
        searchTerm: regExp.pattern,
      ),
    );
  }

  List<Category> filterCategories(
    RegExp regExp,
    List<Category> categories,
  ) {
    List<Category> matchingOrganizers = <Category>[];
    for (var category in categories) {
      Category? result = filterOrganizer(regExp, category) as Category?;
      if (isMatch(result)) {
        matchingOrganizers.add(result!);
      }
    }
    return matchingOrganizers;
  }

  ExpandableOrganizer? filterOrganizer(
      RegExp regExp, ExpandableOrganizer organizer) {
    if (organizer.name.contains(regExp)) {
      return organizer;
    }

    List<Folder> matchingFolders = <Folder>[];
    for (var subOrganizer in organizer.folders) {
      ExpandableOrganizer? result = filterOrganizer(regExp, subOrganizer);
      if (isMatch(result)) {
        matchingFolders.add(result! as Folder);
      }
    }

    List<WidgetElement> matchingWidgets = <WidgetElement>[];
    for (var subOrganizer in organizer.widgets) {
      ExpandableOrganizer? result = filterOrganizer(regExp, subOrganizer);
      if (isMatch(result)) {
        matchingWidgets.add(result! as WidgetElement);
      }
    }

    if (matchingFolders.isNotEmpty) {
      return createFilteredSubtree(
        organizer,
        matchingFolders,
        matchingWidgets,
      );
    }

    return null;
  }

  ExpandableOrganizer createFilteredSubtree(
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
    if (organizer is Folder) {
      return Folder(
        name: organizer.name,
        widgets: widgets,
        folders: folders,
      );
    } else {
      // TODO remove this when tested
      print('This message should never appear - BUG!');
      return Folder(name: 'If you see this, you have found a bug');
    }
  }

  void toggleExpander(ExpandableOrganizer organizer) {
    organizer.isExpanded = !organizer.isExpanded;
    emit(
      OrganizerState(
        allCategories: state.allCategories,
        filteredCategories: state.filteredCategories,
        searchTerm: state.searchTerm,
      ),
    );
  }

  bool isMatch(ExpandableOrganizer? organizer) {
    return organizer != null;
  }
}

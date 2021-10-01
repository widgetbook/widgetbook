import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:widgetbook/src/models/models.dart';
import 'package:widgetbook/src/models/organizers/organizer_helper/organizer_helper.dart';
import 'package:widgetbook/src/providers/organizer_state.dart';
import 'package:widgetbook/src/providers/provider.dart';
import 'package:widgetbook/src/repositories/selected_story_repository.dart';
import 'package:widgetbook/src/repositories/story_repository.dart';

class OrganizerProvider extends Provider<OrganizerState> {
  final SelectedStoryRepository selectedStoryRepository;
  final StoryRepository storyRepository;

  const OrganizerProvider({
    required this.selectedStoryRepository,
    required this.storyRepository,
    required OrganizerState state,
    required ValueChanged<OrganizerState> onStateChanged,
    required Widget child,
    Key? key,
  }) : super(
          state: state,
          onStateChanged: onStateChanged,
          child: child,
          key: key,
        );

  static OrganizerProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<OrganizerProvider>();
  }

  void initialize() {
    selectedStoryRepository.getStream().forEach((Story? story) {
      _openStory(story);
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
      // ignore: avoid_print
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

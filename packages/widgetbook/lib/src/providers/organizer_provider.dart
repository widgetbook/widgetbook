import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:widgetbook/src/models/models.dart';
import 'package:widgetbook/src/models/organizers/organizer_helper/organizer_helper.dart';
import 'package:widgetbook/src/providers/organizer_state.dart';
import 'package:widgetbook/src/providers/provider.dart';
import 'package:widgetbook/src/repositories/selected_story_repository.dart';
import 'package:widgetbook/src/repositories/story_repository.dart';

class OrganizerBuilder extends StatefulWidget {
  final Widget child;
  final List<Category> categories;
  final StoryRepository storyRepository;
  final SelectedStoryRepository selectedStoryRepository;

  const OrganizerBuilder({
    Key? key,
    required this.child,
    required this.categories,
    required this.storyRepository,
    required this.selectedStoryRepository,
  }) : super(key: key);

  @override
  _OrganizerBuilderState createState() => _OrganizerBuilderState();
}

class _OrganizerBuilderState extends State<OrganizerBuilder> {
  late OrganizerState state;
  late OrganizerProvider provider;
  @override
  void initState() {
    state = OrganizerState.unfiltered(
      categories: widget.categories,
    );
    setProvider();

    widget.selectedStoryRepository.getStream().forEach((Story? story) {
      provider.openStory(story);
    });

    super.initState();
  }

  void setProvider() {
    provider = OrganizerProvider(
      selectedStoryRepository: widget.selectedStoryRepository,
      storyRepository: widget.storyRepository,
      state: state,
      onStateChanged: (OrganizerState state) {
        setState(() {
          this.state = state;
          setProvider();
        });
      },
      child: widget.child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return provider;
  }
}

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

  void openStory(Story? story) {
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
      key: (dynamic k) => k.path as String,
      value: (dynamic v) => v as Folder,
    );

    for (var folder in newFolders) {
      var path = folder.path;
      if (oldFolderMap.containsKey(path)) {
        folder.isExpanded = oldFolderMap[path]!.isExpanded;
      }
    }
  }

  void _updateWidgets(List<Category> categories) {
    final oldWidgets = WidgetHelper.getAllWidgetElementsFromCategories(
      state.allCategories,
    );
    final newWidgets = WidgetHelper.getAllWidgetElementsFromCategories(
      categories,
    );
    final oldFolderMap = HashMap<String, WidgetElement>.fromIterable(
      oldWidgets,
      key: (dynamic k) => k.path as String,
      value: (dynamic v) => v as WidgetElement,
    );

    for (final widget in newWidgets) {
      final path = widget.path;
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

  // The filter methods are used to implement a search of organizer elements
  // since no UI element for searching and no tests exist, this functionality
  // is currently disabled
  //
  // void resetFilter() {
  //   emit(
  //     OrganizerState.unfiltered(
  //       categories: state.allCategories,
  //     ),
  //   );
  // }

  // void filter(RegExp regExp) {
  //   var categories = _filterCategories(
  //     regExp,
  //     state.allCategories,
  //   );

  //   emit(
  //     OrganizerState(
  //       allCategories: state.allCategories,
  //       filteredCategories: categories,
  //       searchTerm: regExp.pattern,
  //     ),
  //   );
  // }

  // List<Category> _filterCategories(
  //   RegExp regExp,
  //   List<Category> categories,
  // ) {
  //   List<Category> matchingOrganizers = <Category>[];
  //   for (var category in categories) {
  //     Category? result = _filterOrganizer(regExp, category) as Category?;
  //     if (_isMatch(result)) {
  //       matchingOrganizers.add(result!);
  //     }
  //   }
  //   return matchingOrganizers;
  // }

  // ExpandableOrganizer? _filterOrganizer(
  //     RegExp regExp, ExpandableOrganizer organizer) {
  //   if (organizer.name.contains(regExp)) {
  //     return organizer;
  //   }

  //   List<Folder> matchingFolders = <Folder>[];
  //   for (var subOrganizer in organizer.folders) {
  //     ExpandableOrganizer? result = _filterOrganizer(regExp, subOrganizer);
  //     if (_isMatch(result)) {
  //       matchingFolders.add(result! as Folder);
  //     }
  //   }

  //   List<WidgetElement> matchingWidgets = <WidgetElement>[];
  //   for (var subOrganizer in organizer.widgets) {
  //     ExpandableOrganizer? result = _filterOrganizer(regExp, subOrganizer);
  //     if (_isMatch(result)) {
  //       matchingWidgets.add(result! as WidgetElement);
  //     }
  //   }

  //   if (matchingFolders.isNotEmpty) {
  //     return _createFilteredSubtree(
  //       organizer,
  //       matchingFolders,
  //       matchingWidgets,
  //     );
  //   }

  //   return null;
  // }

  // ExpandableOrganizer _createFilteredSubtree(
  //   ExpandableOrganizer organizer,
  //   List<Folder> folders,
  //   List<WidgetElement> widgets,
  // ) {
  //   if (organizer is Category) {
  //     return Category(
  //       name: organizer.name,
  //       widgets: widgets,
  //       folders: folders,
  //     );
  //   }
  //   if (organizer is Folder) {
  //     return Folder(
  //       name: organizer.name,
  //       widgets: widgets,
  //       folders: folders,
  //     );
  //   } else {
  //     // TODO remove this when tested
  //     // ignore: avoid_print
  //     print('This message should never appear - BUG!');
  //     return Folder(name: 'If you see this, you have found a bug');
  //   }
  // }

  // bool _isMatch(ExpandableOrganizer? organizer) {
  //   return organizer != null;
  // }

  @override
  void emit(OrganizerState state) {
    onStateChanged(state);
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
}

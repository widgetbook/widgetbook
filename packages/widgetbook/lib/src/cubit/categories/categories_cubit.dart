import 'package:bloc/bloc.dart';
import 'package:widgetbook/src/models/organizers/organizers.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<OrganizerState> {
  CategoriesCubit({
    required List<Category> categories,
  }) : super(
          OrganizerState.unfiltered(
            categories: categories,
          ),
        );

  void update(List<Category> categories) {
    // TODO when categories get updated expanded elements are getting collapsed
    // This could be implemented by comparing the 'path' of organizers and copying
    // the property isExpanded if the path matches.
    // comparing paths is probably the best way since the closure
    // might change between hot reloads
    emit(
      OrganizerState.unfiltered(categories: categories),
    );
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

  Organizer? filterOrganizer(RegExp regExp, Organizer organizer) {
    if (organizer.name.contains(regExp)) {
      return organizer;
    }

    List<Folder> matchingFolders = <Folder>[];
    for (var subOrganizer in organizer.folders) {
      Organizer? result = filterOrganizer(regExp, subOrganizer);
      if (isMatch(result)) {
        matchingFolders.add(result! as Folder);
      }
    }

    List<WidgetElement> matchingWidgets = <WidgetElement>[];
    for (var subOrganizer in organizer.widgets) {
      Organizer? result = filterOrganizer(regExp, subOrganizer);
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

  Organizer createFilteredSubtree(
    Organizer organizer,
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

  void toggleExpander(Organizer organizer) {
    organizer.isExpanded = !organizer.isExpanded;
    emit(
      OrganizerState(
        allCategories: state.allCategories,
        filteredCategories: state.filteredCategories,
        searchTerm: state.searchTerm,
      ),
    );
  }

  bool isMatch(Organizer? organizer) {
    return organizer != null;
  }
}

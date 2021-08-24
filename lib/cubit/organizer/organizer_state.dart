part of 'organizer_cubit.dart';

class OrganizerState {
  final List<Category> allCategories;
  final List<Category> filteredCategories;
  final String searchTerm;

  factory OrganizerState.unfiltered({
    required List<Category> categories,
  }) {
    return OrganizerState(
      allCategories: categories,
      filteredCategories: categories,
      searchTerm: '',
    );
  }

  OrganizerState({
    required this.allCategories,
    required this.filteredCategories,
    required this.searchTerm,
  });
}

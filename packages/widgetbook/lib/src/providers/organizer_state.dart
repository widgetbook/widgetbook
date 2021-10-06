import 'package:collection/collection.dart';

import 'package:widgetbook/src/models/models.dart';

class OrganizerState {
  OrganizerState({
    required this.allCategories,
    required this.filteredCategories,
    required this.searchTerm,
  });

  factory OrganizerState.unfiltered({
    required List<Category> categories,
  }) {
    return OrganizerState(
      allCategories: categories,
      filteredCategories: categories,
      searchTerm: '',
    );
  }

  final List<Category> allCategories;
  final List<Category> filteredCategories;
  final String searchTerm;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is OrganizerState &&
        listEquals(other.allCategories, allCategories) &&
        listEquals(other.filteredCategories, filteredCategories) &&
        other.searchTerm == searchTerm;
  }

  @override
  int get hashCode =>
      allCategories.hashCode ^
      filteredCategories.hashCode ^
      searchTerm.hashCode;
}

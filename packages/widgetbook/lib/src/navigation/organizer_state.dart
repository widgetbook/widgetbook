import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook/src/models/models.dart';

part 'organizer_state.freezed.dart';

@freezed
class OrganizerState with _$OrganizerState {
  factory OrganizerState({
    /// The categories before any filter or sorting has been applied
    required List<WidgetbookCategory> initialCategories,
    /// The categories that are filtered and sorted.
    required List<WidgetbookCategory> categories,
    required String searchTerm,
    Sorting? sorting,
  }) = _OrganizerState;

  factory OrganizerState.initial({
    required List<WidgetbookCategory> categories,
  }) {
    return OrganizerState(
      initialCategories: categories,
      categories: categories,
      searchTerm: '',
    );
  }
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook/src/models/models.dart';

part 'organizer_state.freezed.dart';

@freezed
class OrganizerState with _$OrganizerState {
  factory OrganizerState({
    required List<WidgetbookCategory> allCategories,
    required List<WidgetbookCategory> filteredCategories,
    required String searchTerm,
  }) = _OrganizerState;

  factory OrganizerState.unfiltered({
    required List<WidgetbookCategory> categories,
  }) {
    return OrganizerState(
      allCategories: categories,
      filteredCategories: categories,
      searchTerm: '',
    );
  }
}

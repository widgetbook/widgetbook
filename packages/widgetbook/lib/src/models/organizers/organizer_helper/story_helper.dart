import 'package:widgetbook/src/models/organizers/organizer_helper/organizer_helper.dart';
import 'package:widgetbook/src/models/organizers/organizers.dart';

/// Helper to obtain all Stories in the navigation tree.
class StoryHelper {
  static List<WidgetbookUseCase> getAllStoriesFromCategories(
      List<WidgetbookCategory> categories) {
    final widgets = WidgetHelper.getAllWidgetElementsFromCategories(
      categories,
    );

    final stories = List<WidgetbookUseCase>.empty(growable: true);
    for (final widget in widgets) {
      stories.addAll(widget.useCases);
    }

    return stories;
  }
}

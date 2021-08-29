import 'package:widgetbook/src/models/organizers/organizer_helper/organizer_helper.dart';
import 'package:widgetbook/src/models/organizers/organizers.dart';

class StoryHelper {
  static List<Story> getAllStoriesFromCategories(List<Category> categories) {
    List<WidgetElement> widgets =
        WidgetHelper.getAllWidgetElementsFromCategories(
      categories,
    );

    List<Story> stories = List<Story>.empty(growable: true);
    for (var widget in widgets) {
      stories.addAll(widget.stories);
    }

    return stories;
  }
}

import 'package:widgetbook/models/organizers/organizer.dart';
import 'package:widgetbook/models/organizers/story.dart';

class WidgetElement extends Organizer {
  // TODO Maybe passing a type makes more sense than passing a name
  // that has the benefit that the WidgetElement's name will change when the
  // class name changes
  final List<Story> stories;

  WidgetElement({
    required String name,
    required this.stories,
  }) : super(
          name: name,
        ) {
    for (final Story state in stories) {
      state.parent = this;
    }
  }
}

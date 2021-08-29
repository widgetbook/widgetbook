import 'package:recase/recase.dart';
import 'package:widgetbook/src/models/organizers/organizer.dart';
import 'package:widgetbook/src/models/organizers/story.dart';

///
class WidgetElement extends Organizer {
  // TODO Maybe passing a type makes more sense than passing a name
  // that has the benefit that the WidgetElement's name will change when the
  // class name changes
  final List<Story> stories;

  // TODO this was copy pasted and needs refactoring
  String get path {
    String path = ReCase(name).paramCase;
    Organizer? current = parent;
    while (current?.parent != null) {
      path = '${ReCase(current!.name).paramCase}${'/$path'}';
      current = current.parent;
    }
    return path;
  }

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

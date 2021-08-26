import 'package:widgetbook/src/models/organizers/folder.dart';
import 'package:widgetbook/src/models/organizers/organizer.dart';
import 'package:widgetbook/src/models/organizers/widget_element.dart';

/// Categories help to organize WidgetElements and Stories into different areas.
class Category extends Organizer {
  Category({
    required String name,
    List<Folder>? folders,
    List<WidgetElement>? widgets,
  }) : super(
          name: name,
          folders: folders,
          widgets: widgets,
        ) {
    for (final Organizer organizer in this.folders) {
      organizer.parent = this;
    }
    for (final Organizer organizer in this.widgets) {
      organizer.parent = this;
    }
  }
}

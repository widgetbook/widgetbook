import 'package:widgetbook/src/models/organizers/expandable_organizer.dart';
import 'package:widgetbook/src/models/organizers/folder.dart';
import 'package:widgetbook/src/models/organizers/widget_element.dart';

/// Categories help to organize WidgetElements and Stories into different areas.
class Category extends ExpandableOrganizer {
  Category({
    required String name,
    List<Folder>? folders,
    List<WidgetElement>? widgets,
  }) : super(
          name: name,
          folders: folders,
          widgets: widgets,
        ) {
    for (final ExpandableOrganizer organizer in this.folders) {
      organizer.parent = this;
    }
    for (final ExpandableOrganizer organizer in this.widgets) {
      organizer.parent = this;
    }
  }
}

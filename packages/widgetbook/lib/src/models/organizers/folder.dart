import 'package:widgetbook/src/models/organizers/expandable_organizer.dart';
import 'package:widgetbook/src/models/organizers/organizers.dart';
import 'package:widgetbook/src/models/organizers/widget_element.dart';

/// A folder in the folder tree.
class Folder extends ExpandableOrganizer {
  Folder({
    required String name,
    List<Folder>? folders,
    List<WidgetElement>? widgets,
    bool isExpanded = false,
  }) : super(
          name: name,
          folders: folders,
          widgets: widgets,
          isExpanded: isExpanded,
        ) {
    for (final ExpandableOrganizer organizer in this.folders) {
      organizer.parent = this;
    }
    for (final organizer in this.widgets) {
      organizer.parent = this;
    }
  }
}

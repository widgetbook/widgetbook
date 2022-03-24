import 'package:widgetbook/src/models/organizers/organizers.dart';

/// A folder in the folder tree.
class WidgetbookFolder extends ExpandableOrganizer {
  WidgetbookFolder({
    required String name,
    List<WidgetbookFolder>? folders,
    List<WidgetbookComponent>? widgets,
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
  @override
  String toString() {
    return 'name: $name, expanded: $isExpanded, folders: $folders, widgets: $widgets';
  }
}

import 'package:widgetbook/src/models/organizers/expandable_organizer.dart';
import 'package:widgetbook/src/models/organizers/widgetbook_folder.dart';
import 'package:widgetbook/src/models/organizers/widgetbook_widget.dart';

/// Categories help to organize WidgetElements and Stories into different areas.
// TODO would be great if this uses freezed
class WidgetbookCategory extends ExpandableOrganizer {
  WidgetbookCategory({
    required String name,
    List<WidgetbookFolder>? folders,
    List<WidgetbookComponent>? widgets,
    bool isExpanded = true,
  }) : super(
          name: name,
          folders: folders,
          widgets: widgets,
          isExpanded: isExpanded,
        ) {
    for (final ExpandableOrganizer organizer in this.folders) {
      organizer.parent = this;
    }
    for (final ExpandableOrganizer organizer in this.widgets) {
      organizer.parent = this;
    }
  }

  @override
  String toString() {
    return 'isExpanded: $isExpanded, folders: $folders, widgets: $widgets';
  }
}

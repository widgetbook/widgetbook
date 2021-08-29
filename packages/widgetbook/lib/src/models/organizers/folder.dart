import 'package:recase/recase.dart';
import 'package:widgetbook/src/models/organizers/organizer.dart';
import 'package:widgetbook/src/models/organizers/widget_element.dart';

/// A folder in the folder tree.
class Folder extends Organizer {
  // TODO this was copy pasted and need refactoring
  String get path {
    String path = ReCase(name).paramCase;
    Organizer? current = parent;
    while (current?.parent != null) {
      path = '${ReCase(current!.name).paramCase}${'/$path'}';
      current = current.parent;
    }
    return path;
  }

  Folder({
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
    for (final WidgetElement organizer in this.widgets) {
      organizer.parent = this;
    }
  }
}

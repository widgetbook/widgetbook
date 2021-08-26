import 'package:widgetbook/src/models/organizers/organizer_base.dart';
import 'package:widgetbook/src/models/organizers/organizers.dart';

abstract class Organizer extends OrganizerBase {
  bool isExpanded;
  final List<Folder> folders;
  final List<WidgetElement> widgets;
  Organizer? parent;

  /// Abstract class for organizer panel in the left.
  Organizer({
    required String name,
    this.isExpanded = false,
    List<Folder>? folders,
    List<WidgetElement>? widgets,
  })  : this.folders = folders ?? List<Folder>.empty(),
        this.widgets = widgets ?? List<WidgetElement>.empty(),
        super(name);
}

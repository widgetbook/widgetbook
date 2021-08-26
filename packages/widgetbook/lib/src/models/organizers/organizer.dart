import 'package:widgetbook/src/models/organizers/organizer_base.dart';
import 'package:widgetbook/src/models/organizers/organizers.dart';

/// Organizers is an abstract model which helps to
/// structure Categories, WidgetElements and Stories in the folder tree.
abstract class Organizer extends OrganizerBase {
  /// Used to implement collapsing and expanding of the folder tree.
  bool isExpanded;

  /// The folders of one level in the folder tree.
  /// Folders will be shown above widgets.
  final List<Folder> folders;

  /// The widgets of one level in the folder tree.
  /// Widgets will be shown below folders;
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

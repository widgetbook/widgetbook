/// Organizer is an abstract model which helps to
/// structure Categories, WidgetElements and Stories in the folder tree.
abstract class Organizer {
  Organizer(this.name);

  /// Used to display the name of the Folder or WidgetElement
  final String name;

  /// Used for navigation and matching hot reloaded elements with existing
  String get path {
    var path = name.replaceAll(' ', '-').toLowerCase();
    var current = parent;
    while (current?.parent != null) {
      path = '${current!.name.replaceAll(' ', '-').toLowerCase()}${'/$path'}';
      current = current.parent;
    }
    return path;
  }

  /// The Organizer hosting this element.
  Organizer? parent;
}

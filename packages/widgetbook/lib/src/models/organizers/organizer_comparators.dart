import 'package:widgetbook/src/models/models.dart';

class OrganizerComparators {
  static Comparator<Organizer> get byNameAsc =>
      (a, b) => a.name.compareTo(b.name);

  static Comparator<Organizer> get byNameDesc =>
      (a, b) => b.name.compareTo(a.name);
}

import 'package:collection/collection.dart';

import 'package:widgetbook/src/models/organizers/expandable_organizer.dart';
import 'package:widgetbook/src/models/organizers/organizers.dart';
import 'package:widgetbook/src/models/organizers/story.dart';

///
class WidgetElement extends ExpandableOrganizer {
  // TODO Maybe passing a type makes more sense than passing a name
  // that has the benefit that the WidgetElement's name will change when the
  // class name changes
  //
  // This could be avoided alltogether by using annotations
  final List<Story> stories;

  WidgetElement({
    required String name,
    required this.stories,
    bool isExpanded = false,
  }) : super(
          name: name,
          isExpanded: isExpanded,
        ) {
    for (final Story state in stories) {
      state.parent = this;
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is WidgetElement && listEquals(other.stories, stories);
  }

  @override
  int get hashCode => stories.hashCode;
}

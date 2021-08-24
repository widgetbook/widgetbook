import 'package:flutter/material.dart';
import 'package:widgetbook/models/organizers/organizer.dart';
import 'package:widgetbook/models/organizers/organizer_base.dart';
import 'package:widgetbook/models/organizers/widget_element.dart';
import 'package:recase/recase.dart';

class Story extends OrganizerBase {
  final Widget Function(BuildContext) builder;
  WidgetElement? parent;

  String get path {
    String path = ReCase(name).paramCase;
    Organizer? current = parent;
    while (current?.parent != null) {
      path = '${ReCase(current!.parent!.name).paramCase}${'/$path'}';
      current = current.parent;
    }
    return path;
  }

  Story({required String name, required this.builder}) : super(name);

  factory Story.center({
    required String name,
    required Widget child,
  }) {
    return Story(
      name: name,
      builder: (_) => Center(child: child),
    );
  }

  factory Story.child({
    required String name,
    required Widget child,
  }) {
    return Story(
      name: name,
      builder: (_) => child,
    );
  }
}

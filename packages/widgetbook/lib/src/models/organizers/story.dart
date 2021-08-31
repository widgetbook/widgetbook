import 'package:flutter/material.dart';
import 'package:widgetbook/src/models/model.dart';
import 'package:widgetbook/src/models/organizers/organizer.dart';

/// Stories represent a specific configuration of a widget.
class Story extends Organizer implements Model {
  final Widget Function(BuildContext) builder;

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

  @override
  String get id => path;
}

import 'package:flutter/widgets.dart';

import '../../../../widgetbook.dart';
import 'mode.dart';
import 'modes_addon.dart';

typedef ChildBuilder = Widget Function(BuildContext context, Widget child);

class BuilderMode extends Mode<ChildBuilder> {
  BuilderMode(super.builder);

  @override
  Widget build(BuildContext context, Widget child) {
    return value(context, child);
  }
}

class BuilderAddon extends ModesAddon<BuilderMode> {
  BuilderAddon({
    required super.name,
    required ChildBuilder builder,
  }) : super(
          modes: [
            BuilderMode(builder),
          ],
        );

  @override
  List<Field> get fields => [];

  @override
  BuilderMode valueFromQueryGroup(Map<String, String> group) {
    return modes.first;
  }
}

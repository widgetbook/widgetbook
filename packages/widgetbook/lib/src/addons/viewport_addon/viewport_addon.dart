import 'package:flutter/widgets.dart' hide Viewport;

import '../../core/core.dart';
import '../../fields/fields.dart';
import 'viewport.dart';
import 'viewport_data.dart';
import 'viewports/viewports.dart';

class ViewportMode extends Mode<ViewportData> {
  ViewportMode(ViewportData value)
    : super(
        value,
        ViewportAddon(
          [value],
          showFrame: false,
        ),
      );
}

/// An [Addon] that allows switching between different viewports.
class ViewportAddon extends Addon<ViewportData> {
  ViewportAddon(
    this.viewports, {
    this.showFrame = true,
  }) : super(name: 'Viewport');

  final List<ViewportData> viewports;
  final bool showFrame;

  @override
  List<Field> get fields {
    return [
      ObjectDropdownField<ViewportData>(
        name: 'name',
        initialValue: viewports.first,
        values: viewports,
        labelBuilder: (viewport) => viewport.name,
      ),
    ];
  }

  @override
  Widget buildUseCase(
    BuildContext context,
    Widget child,
    ViewportData setting,
  ) {
    if (setting is NoneViewport) return child;

    return Center(
      child: Viewport(
        data: setting,
        frameless: !showFrame,
        child: child,
      ),
    );
  }
}

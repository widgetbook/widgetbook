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
class ViewportAddon extends Addon<ViewportData> with SingleFieldOnly {
  ViewportAddon(
    this.viewports, {
    this.showFrame = true,
  }) : super(
         name: 'Viewport',
         initialValue: viewports.first,
       );

  final List<ViewportData> viewports;
  final bool showFrame;

  @override
  Field<ViewportData> get field {
    return ObjectDropdownField<ViewportData>(
      name: 'name',
      initialValue: initialValue,
      values: viewports,
      labelBuilder: (viewport) => viewport.name,
    );
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

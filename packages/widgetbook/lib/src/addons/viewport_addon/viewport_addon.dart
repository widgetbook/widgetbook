import 'package:flutter/widgets.dart' hide Viewport;

import '../../core/core.dart';
import '../../fields/fields.dart';
import '../../state/state.dart';
import 'viewport.dart';
import 'viewport_data.dart';
import 'viewports/viewports.dart';

class ViewportMode extends Mode<ViewportData> {
  ViewportMode(ViewportData value) : super(value, ViewportAddon([value]));
}

/// An [Addon] that allows switching between different viewports.
class ViewportAddon extends Addon<ViewportData> {
  ViewportAddon(this.viewports) : super(name: 'Viewport');

  final List<ViewportData> viewports;

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
  ViewportData valueFromQueryGroup(Map<String, String> group) {
    return valueOf<ViewportData>('name', group)!;
  }

  @override
  Map<String, String> valueToQueryGroup(ViewportData value) {
    return {'name': paramOf('name', value)};
  }

  @override
  Widget buildUseCase(
    BuildContext context,
    Widget child,
    ViewportData setting,
  ) {
    if (setting is NoneViewport) return child;

    // Enable frameless mode if the preview mode is enabled
    final frameless = WidgetbookState.of(context).previewMode;

    return Center(
      child: Viewport(
        data: setting,
        frameless: frameless,
        child: child,
      ),
    );
  }
}

import 'package:flutter/widgets.dart' hide Viewport;

import '../../core/addon.dart';
import '../../core/mode.dart';
import '../../core/mode_addon.dart';
import '../../fields/fields.dart';
import '../../state/state.dart';
import 'viewport.dart';
import 'viewport_data.dart';
import 'viewports/viewports.dart';

class ViewportMode extends Mode<ViewportData> {
  ViewportMode(super.value);

  @override
  Widget build(BuildContext context, Widget child) {
    if (value is NoneViewport) return child;

    // Enable frameless mode if the preview mode is enabled
    final frameless = WidgetbookState.of(context).previewMode;

    return Center(
      child: Viewport(
        data: value,
        frameless: frameless,
        child: child,
      ),
    );
  }
}

/// An [Addon] that allows switching between different viewports.
class ViewportAddon extends ModeAddon<ViewportData> {
  ViewportAddon(this.viewports)
    : super(
        name: 'Viewport',
        modeBuilder: ViewportMode.new,
      );

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
}

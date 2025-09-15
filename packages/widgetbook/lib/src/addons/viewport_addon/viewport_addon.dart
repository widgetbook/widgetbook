import 'package:flutter/material.dart' hide Viewport;
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../../fields/fields.dart';
import '../../state/state.dart';
import '../common/common.dart';
import 'viewport.dart';
import 'viewport_data.dart';
import 'viewports/viewports.dart';

/// [AddonConfig] for the [ViewportAddon].
class ViewportAddonConfig extends AddonConfig<ViewportData> {
  // NOTE: this cannot be defined in widgetbook_annotation because it depends on
  // the ViewportData class which is defined in this file.
  // If we add `widgetbook` as a dependency to `widgetbook_annotation`, then the
  // `widgetbook_generator` will also depend on `widgetbook` which causes
  // it to not work, as `widgetbook` has flutter as a dependency.

  /// Creates a configuration for the [ViewportAddon] with the specified [data].
  const ViewportAddonConfig(
    ViewportData data,
  ) : assert(
        data is! NoneViewport,
        '`NoneViewport` cannot be used in addon config',
      ),
      super(
        'viewport',
        // It would have been easier to parse the `data` to the string format
        // that is required by the Cloud (i.e. "id:${data.id},$meta{...}")
        // but we cannot do this here, because it's a constant class that
        // is used as an annotation, so the parsing is done in the generator.
        // For that reason, we have the generic parameter on AddonConfig.
        data,
      );
}

/// A [WidgetbookAddon] that allows switching between different viewports.
///
/// The [ViewportAddon] enables users to test their widgets on different screen
/// sizes, from mobile phones to tablets and desktops. This is essential for
/// responsive design testing.
///
/// Learn more: https://docs.widgetbook.io/addons/viewport-addon
class ViewportAddon extends WidgetbookAddon<ViewportData> {
  /// Creates a new instance of [ViewportAddon].
  ViewportAddon(this.viewports)
    : super(
        name: 'Viewport',
      );

  /// The list of available viewport options.
  final List<ViewportData> viewports;

  @override
  List<Field> get fields => [
    ObjectDropdownField<ViewportData>(
      name: 'name',
      initialValue: viewports.first,
      values: viewports,
      labelBuilder: (viewport) => viewport.name,
    ),
  ];

  @override
  ViewportData valueFromQueryGroup(Map<String, String> group) {
    return valueOf<ViewportData>('name', group)!;
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

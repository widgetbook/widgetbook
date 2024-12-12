import 'package:flutter/material.dart' hide Viewport;
import 'package:meta/meta.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../../fields/fields.dart';
import '../../state/state.dart';
import '../common/common.dart';
import 'viewport.dart';
import 'viewport_data.dart';

// NOTE: this cannot be defined in widgetbook_annotation because it depends on
// the ViewportData class which is defined in this file.
// If we add `widgetbook` as a dependency to `widgetbook_annotation`, then the
// `widgetbook_generator` will also depend on `widgetbook` which causes
// it to not work, as `widgetbook` has flutter as a dependency.
@experimental
class ViewportAddonConfig extends AddonConfig<ViewportData> {
  const ViewportAddonConfig(
    ViewportData data,
  ) : super(
          'viewport',
          data,
        );
}

@experimental
class ViewportAddon extends WidgetbookAddon<ViewportData?> {
  ViewportAddon(this.viewports)
      : super(
          name: 'Viewport',
        );

  final List<ViewportData?> viewports;

  @override
  List<Field> get fields => [
        ListField<ViewportData?>(
          name: 'id',
          initialValue: viewports.first,
          values: viewports,
          labelBuilder: (viewport) => viewport?.id ?? '',
        ),
      ];

  @override
  ViewportData? valueFromQueryGroup(Map<String, String> group) {
    return valueOf<ViewportData?>('id', group);
  }

  @override
  Widget buildUseCase(
    BuildContext context,
    Widget child,
    ViewportData? setting,
  ) {
    if (setting == null) return child;

    // Do not show the frame if the preview mode is enabled
    final hideFrame = WidgetbookState.of(context).previewMode;
    final frameColor = Colors.green;

    return Center(
      child: Viewport(
        data: setting,
        frameColor: hideFrame ? null : frameColor,
        child: child,
      ),
    );
  }
}

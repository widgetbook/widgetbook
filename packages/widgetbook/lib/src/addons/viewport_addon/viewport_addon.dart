import 'package:flutter/material.dart' hide Viewport;
import 'package:meta/meta.dart';

import '../../fields/fields.dart';
import '../../state/state.dart';
import '../common/common.dart';
import 'viewport.dart';
import 'viewport_data.dart';

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

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

ScaffoldBuilderFunction get defaultScaffoldBuilder => (
      BuildContext context,
      WidgetbookFrame deviceFrame,
      Widget child,
    ) {
      if (deviceFrame == WidgetbookFrame.defaultFrame() ||
          deviceFrame == WidgetbookFrame.deviceFrame()) {
        return Scaffold(
          body: child,
        );
      }

      return child;
    };

typedef ScaffoldBuilderFunction = Widget Function(
  BuildContext context,
  WidgetbookFrame deviceFrame,
  Widget child,
);

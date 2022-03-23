import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

ScaffoldBuilderFunction get defaultScaffoldBuilder => (
      BuildContext context,
      WidgetbookFrame frame,
      Widget child,
    ) {
      if (frame.allowsDevices) {
        return ScaffoldMessenger(
          child: Scaffold(
            body: child,
          ),
        );
      }

      return child;
    };

typedef ScaffoldBuilderFunction = Widget Function(
  BuildContext context,
  WidgetbookFrame frame,
  Widget child,
);

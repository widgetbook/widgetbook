import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

ScaffoldBuilderFunction get defaultScaffoldBuilder => (
      BuildContext context,
      DeviceFrame deviceFrame,
      Widget child,
    ) {
      if (deviceFrame == DeviceFrame.widgetbook() ||
          deviceFrame == DeviceFrame.devicePreview()) {
        return Scaffold(
          body: child,
        );
      }

      return child;
    };

typedef ScaffoldBuilderFunction = Widget Function(
  BuildContext context,
  DeviceFrame deviceFrame,
  Widget child,
);

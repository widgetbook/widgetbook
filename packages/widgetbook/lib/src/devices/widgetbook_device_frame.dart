import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

class WidgetbookDeviceFrame extends StatelessWidget {
  const WidgetbookDeviceFrame({
    Key? key,
    required this.device,
    required this.child,
  }) : super(key: key);

  final Device device;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
      ),
      width: device.resolution.logicalSize.width,
      height: device.resolution.logicalSize.height,
      child: child,
    );
  }
}

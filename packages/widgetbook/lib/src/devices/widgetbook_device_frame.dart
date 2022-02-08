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

  MediaQueryData mediaQuery({
    required BuildContext context,
  }) {
    final mediaQuery = MediaQuery.of(context);
    final viewPadding = mediaQuery.padding;

    final width = device.resolution.logicalSize.width;
    final height = device.resolution.logicalSize.height;

    final deviceQuery = mediaQuery.copyWith(
      size: Size(width, height),
      padding: viewPadding,
      viewInsets: EdgeInsets.zero,
      viewPadding: viewPadding,
      devicePixelRatio: device.resolution.scaleFactor,
    );

    return deviceQuery;
  }

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
      child: MediaQuery(
        data: mediaQuery(
          context: context,
        ),
        child: child,
      ),
    );
  }
}

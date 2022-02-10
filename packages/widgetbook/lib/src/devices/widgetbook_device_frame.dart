import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

class WidgetbookDeviceFrame extends StatelessWidget {
  const WidgetbookDeviceFrame({
    Key? key,
    required this.device,
    required this.child,
    required this.orientation,
  }) : super(key: key);

  final Device device;
  final Widget child;
  final Orientation orientation;

  bool get _isLandscape {
    return orientation == Orientation.landscape &&
        device.type != DeviceType.desktop;
  }

  double get _width {
    return _isLandscape
        ? device.resolution.logicalSize.height
        : device.resolution.logicalSize.width;
  }

  double get _height {
    return _isLandscape
        ? device.resolution.logicalSize.width
        : device.resolution.logicalSize.height;
  }

  MediaQueryData mediaQuery({
    required BuildContext context,
  }) {
    final mediaQuery = MediaQuery.of(context);
    final viewPadding = mediaQuery.padding;

    final deviceQuery = mediaQuery.copyWith(
      size: Size(_width, _height),
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
      width: _width,
      height: _height,
      child: MediaQuery(
        data: mediaQuery(
          context: context,
        ),
        child: child,
      ),
    );
  }
}

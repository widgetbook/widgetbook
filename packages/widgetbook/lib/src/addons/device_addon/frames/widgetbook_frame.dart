import 'package:flutter/widgets.dart';
import 'package:widgetbook_models/widgetbook_models.dart';

import 'frame_builder.dart';

class WidgetbookFrame extends FrameBuilder {
  WidgetbookFrame({
    required super.setting,
  }) : assert(
          setting.activeDevice != null,
          'device cannot be null',
        );

  MediaQueryData mediaQuery({
    required BuildContext context,
    required Device? info,
    required Orientation orientation,
  }) {
    final mediaQuery = MediaQuery.of(context);
    final isRotated = setting.orientation == Orientation.landscape;
    final viewPadding = mediaQuery.padding;

    final screenSize = info != null
        ? Size(
            info.resolution.logicalSize.width,
            info.resolution.logicalSize.height,
          )
        : mediaQuery.size;
    final width = isRotated ? screenSize.height : screenSize.width;
    final height = isRotated ? screenSize.width : screenSize.height;

    return mediaQuery.copyWith(
      size: Size(width, height),
      padding: viewPadding,
      viewInsets: EdgeInsets.zero,
      viewPadding: viewPadding,
      devicePixelRatio:
          info?.resolution.scaleFactor ?? mediaQuery.devicePixelRatio,
    );
  }

  Widget _screen(BuildContext context, Widget screen, Device? info) {
    final mediaQuery = MediaQuery.of(context);
    final isRotated = setting.orientation == Orientation.landscape;
    final screenSize = info != null
        ? Size(
            info.resolution.logicalSize.width,
            info.resolution.logicalSize.height,
          )
        : mediaQuery.size;
    final width = isRotated ? screenSize.height : screenSize.width;
    final height = isRotated ? screenSize.width : screenSize.height;

    return RotatedBox(
      quarterTurns: isRotated ? 1 : 0,
      child: SizedBox(
        width: width,
        height: height,
        child: MediaQuery(
          data: this.mediaQuery(
            info: info,
            orientation: Orientation.portrait,
            context: context,
          ),
          child: screen,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, Widget child) {
    final device = setting.activeDevice!;
    final frameSize = device.resolution.logicalSize;
    final stack = SizedBox(
      width: frameSize.width,
      height: frameSize.height,
      child: Stack(
        children: [
          Positioned(
            key: const Key('Screen'),
            left: 0,
            top: 0,
            width: frameSize.width,
            height: frameSize.height,
            child: ClipPath(
              clipper: _ScreenClipper(
                Path()
                  ..addRect(
                    Rect.fromLTWH(
                      0,
                      0,
                      device.resolution.logicalSize.width,
                      device.resolution.logicalSize.height,
                    ),
                  ),
              ),
              child: FittedBox(
                child: _screen(context, child, device),
              ),
            ),
          ),
        ],
      ),
    );

    final isRotated = setting.orientation == Orientation.landscape;

    return FittedBox(
      key: const Key('widgetbook_device_edge_bond'),
      child: RotatedBox(
        quarterTurns: isRotated ? -1 : 0,
        child: stack,
      ),
    );
  }
}

class _ScreenClipper extends CustomClipper<Path> {
  const _ScreenClipper(this.path);

  final Path? path;

  @override
  Path getClip(Size size) {
    final path = this.path ?? (Path()..addRect(Offset.zero & size));
    final bounds = path.getBounds();
    final transform = Matrix4.translationValues(-bounds.left, -bounds.top, 0);

    return path.transform(transform.storage);
  }

  @override
  bool shouldReclip(_ScreenClipper oldClipper) {
    return oldClipper.path != path;
  }
}

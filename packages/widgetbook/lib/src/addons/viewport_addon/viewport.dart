import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'viewport_data.dart';

@experimental
class Viewport extends StatelessWidget {
  const Viewport({
    super.key,
    required this.data,
    required this.frameColor,
    required this.child,
  });

  final ViewportData data;
  final Color? frameColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).copyWith(
      size: data.size,
      devicePixelRatio: data.pixelRatio,
    );

    final theme = Theme.of(context).copyWith(
      platform: data.platform,
    );

    return FittedBox(
      child: _ViewportFrame(
        title: data.name ?? data.id,
        color: frameColor,
        child: SizedBox(
          width: data.width,
          height: data.height,
          child: Theme(
            data: theme,
            child: MediaQuery(
              data: mediaQuery,
              child: Navigator(
                // A navigator below the device frame is necessary to make
                // the popup routes (e.g. dialogs and bottom sheets) work within
                // the device frame, otherwise they would use the navigator from
                // the app builder, causing these routes to fill the whole
                // workbench and not just the device frame.
                onGenerateRoute: (_) => PageRouteBuilder(
                  pageBuilder: (context, _, __) => child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ViewportFrame extends StatelessWidget {
  const _ViewportFrame({
    required this.title,
    required this.color,
    required this.child,
  });

  final String title;
  final Color? color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final frameColor = color;

    // If no frame color is provided, don't wrap the child in a frame
    if (frameColor == null) {
      return child;
    }

    final borderWidth = 2.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Transform.translate(
          offset: Offset(-borderWidth, 0),
          child: Container(
            child: Text(title),
            color: frameColor,
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 12,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: frameColor,
              width: borderWidth,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
          ),
          child: child,
        ),
      ],
    );
  }
}

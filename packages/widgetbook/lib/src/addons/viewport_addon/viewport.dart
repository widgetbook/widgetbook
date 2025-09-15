import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:nested/nested.dart';

import '../../widgetbook_theme.dart';
import 'viewport_data.dart';

@internal
class Viewport extends StatelessWidget {
  const Viewport({
    super.key,
    required this.data,
    required this.frameless,
    required this.child,
  });

  final ViewportData data;
  final bool frameless;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).copyWith(
      size: data.size,
      devicePixelRatio: data.pixelRatio,
      padding: data.safeAreas,
      viewPadding: data.safeAreas,
    );

    final theme = Theme.of(context).copyWith(
      platform: data.platform,
    );

    return FittedBox(
      child: Nested(
        children: [
          SingleChildBuilder(
            builder: (context, child) {
              // Exclude frame if frameless mode is enabled
              return frameless
                  ? child!
                  : Padding(
                    // Padding is needed to make sure that the frame's edge
                    // is not on directly on the workbench's edge, but
                    // we don't want that in the frameless mode
                    padding: const EdgeInsets.all(16),
                    child: _ViewportFrame(
                      title: data.name,
                      child: child!,
                    ),
                  );
            },
          ),
        ],
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
                onGenerateRoute:
                    (_) => PageRouteBuilder(
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

/// A frame around the viewport that displays the viewport's title
/// and a border around the viewport.
class _ViewportFrame extends StatelessWidget {
  const _ViewportFrame({
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final color = Colors.green;
    final borderWidth = 2.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Transform.translate(
          offset: Offset(-borderWidth, 0),
          child: Container(
            color: color,
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 12,
            ),
            child: Text(
              title,
              style: WidgetbookTheme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.black87,
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: color,
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

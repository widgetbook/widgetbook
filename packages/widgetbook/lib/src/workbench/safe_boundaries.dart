import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// Sets safe boundaries around [child] for proper rendering.
/// This is needed for widgets that depend on [MediaQuery],
/// for example: widgets from `flutter_screenutil` package.
@internal
class SafeBoundaries extends StatelessWidget {
  const SafeBoundaries({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: LayoutBuilder(
        builder: (context, constrains) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              size: Size(
                constrains.maxWidth,
                constrains.maxHeight,
              ),
            ),
            child: child,
          );
        },
      ),
    );
  }
}

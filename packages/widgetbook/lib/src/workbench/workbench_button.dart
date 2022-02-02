import 'package:flutter/material.dart';
import 'package:widgetbook/src/constants/radii.dart';

/// A custom button used in the Workbench which can be reused by all the
/// clickable elements
///
/// [WorkbenchButton] has two styles:
/// - [WorkbenchButton.icon] which is similar to an [IconButton].
/// - [WorkbenchButton.text] for text.
class WorkbenchButton extends StatelessWidget {
  const WorkbenchButton._({
    Key? key,
    required this.onPressed,
    required this.child,
    Color? color,
    this.radius = Radii.defaultRadius,
  })  : color = color ?? Colors.transparent,
        super(key: key);

  /// Creates a new [WorkbenchButton] which can host [Icon]s.
  factory WorkbenchButton.icon({
    required VoidCallback onPressed,
    required Widget child,
  }) {
    return WorkbenchButton._(
      onPressed: onPressed,
      radius: BorderRadius.circular(100),
      child: child,
    );
  }

  /// Creates a new [WorkbenchButton] which can host [Text]s.
  factory WorkbenchButton.text({
    required VoidCallback onPressed,
    required Widget child,
    Color? color,
  }) {
    return WorkbenchButton._(
      onPressed: onPressed,
      color: color,
      child: child,
    );
  }

  final VoidCallback onPressed;
  final Color color;
  final BorderRadius radius;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: radius,
        ),
        hoverColor: Theme.of(context).cardColor,
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            borderRadius: radius,
            color: color,
          ),
          child: child,
        ),
      ),
    );
  }
}

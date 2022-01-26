import 'package:flutter/material.dart';
// TODO(dkbast): What do you think about this extension method.
import 'package:widgetbook/src/utils/extensions.dart';

class IterationButton extends StatelessWidget {
  const IterationButton._({
    Key? key,
    required this.onPressed,
    required this.iconData,
  }) : super(key: key);

  factory IterationButton.left({
    required VoidCallback onPressed,
  }) {
    return IterationButton._(
      onPressed: onPressed,
      iconData: Icons.chevron_left,
    );
  }

  factory IterationButton.right({
    required VoidCallback onPressed,
  }) {
    return IterationButton._(
      onPressed: onPressed,
      iconData: Icons.chevron_right,
    );
  }

  final VoidCallback onPressed;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        splashFactory: InkRipple.splashFactory,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
        minimumSize: Size.zero,
        padding: const EdgeInsets.all(12),
      ),
      child: Icon(
        iconData,
        color: context.theme.hintColor,
      ),
    );
  }
}

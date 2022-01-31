import 'package:flutter/material.dart';
import 'package:widgetbook/src/utils/extensions.dart';
import 'package:widgetbook/src/workbench/workbench_button.dart';

/// A button with a chevron indicating some sort of iteration within a
/// collection of Workbench settings.
///
/// [IterationButton] defines two different variants:
/// - [IterationButton.previous] for selecting the previous setting.
/// - [IterationButton.next] for selecting the next setting.
class IterationButton extends StatelessWidget {
  const IterationButton._({
    Key? key,
    required this.onPressed,
    required this.iconData,
  }) : super(key: key);

  factory IterationButton.previous({
    required VoidCallback onPressed,
  }) {
    return IterationButton._(
      onPressed: onPressed,
      iconData: Icons.chevron_left,
    );
  }

  factory IterationButton.next({
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
    return WorkbenchButton.icon(
      onPressed: onPressed,
      child: Icon(
        iconData,
        color: context.theme.hintColor,
      ),
    );
  }
}

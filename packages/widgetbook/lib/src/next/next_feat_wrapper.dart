import 'package:flutter/material.dart';

class NextFeatWrapper extends StatelessWidget {
  const NextFeatWrapper({
    super.key,
    this.enable = true,
    required this.child,
  });

  final bool enable;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return !enable
        ? child
        : Tooltip(
            message: 'Experimental',
            child: Badge(
              backgroundColor: Colors.red,
              smallSize: 8,
              alignment: AlignmentDirectional.centerStart,
              child: child,
            ),
          );
  }
}

import 'package:flutter/material.dart';

class Unfocuser extends StatelessWidget {
  const Unfocuser({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: WidgetsBinding.instance!.focusManager.primaryFocus?.unfocus,
      child: child,
    );
  }
}

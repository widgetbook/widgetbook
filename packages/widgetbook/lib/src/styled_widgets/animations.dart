import 'package:flutter/material.dart';

class StatefulAnimatedSize extends StatefulWidget {
  const StatefulAnimatedSize({
    Key? key,
    required this.child,
    required this.duration,
    this.curve = Curves.linear,
  }) : super(key: key);

  final Widget child;
  final Duration duration;
  final Curve curve;

  @override
  _StatefulAnimatedSizeState createState() => _StatefulAnimatedSizeState();
}

class _StatefulAnimatedSizeState extends State<StatefulAnimatedSize>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: widget.duration,
      curve: widget.curve,
      child: widget.child,
    );
  }
}

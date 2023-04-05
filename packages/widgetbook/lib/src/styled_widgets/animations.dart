import 'package:flutter/material.dart';

class StatefulAnimatedSize extends StatefulWidget {
  const StatefulAnimatedSize({
    required this.child,
    required this.duration,
    super.key,
    this.curve = Curves.linear,
  });

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

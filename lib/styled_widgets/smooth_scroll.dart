import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

const int kDefaultScrollDuration = 250;
const int kDefaultScrollSpeed = 130;

class SmoothScroll extends StatefulWidget {
  final ScrollController controller;

  final Widget child;

  final int scrollSpeed;

  final int scrollDuration;

  final Curve curve;

  const SmoothScroll({
    required this.controller,
    required this.child,
    this.scrollSpeed = kDefaultScrollSpeed,
    this.scrollDuration = kDefaultScrollDuration,
    this.curve = Curves.linear,
  });

  @override
  _SmoothScrollState createState() => _SmoothScrollState();
}

class _SmoothScrollState extends State<SmoothScroll> {
  double _scroll = 0;

  @override
  Widget build(BuildContext context) {
    widget.controller.addListener(() {
      if (widget.controller.position.activity is IdleScrollActivity) {
        _scroll = widget.controller.position.extentBefore;
      }
    });

    return Listener(
      onPointerSignal: (pointerSignal) {
        int millis = widget.scrollDuration;
        if (pointerSignal is PointerScrollEvent) {
          if (pointerSignal.scrollDelta.dy > 0) {
            _scroll += widget.scrollSpeed;
          } else {
            _scroll -= widget.scrollSpeed;
          }
          if (_scroll > widget.controller.position.maxScrollExtent) {
            _scroll = widget.controller.position.maxScrollExtent;
            millis = widget.scrollDuration ~/ 2;
          }
          if (_scroll < 0) {
            _scroll = 0;
            millis = widget.scrollDuration ~/ 2;
          }

          widget.controller.animateTo(
            _scroll,
            duration: Duration(milliseconds: millis),
            curve: widget.curve,
          );
        }
      },
      child: widget.child,
    );
  }
}

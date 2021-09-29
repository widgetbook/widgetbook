import 'package:flutter/material.dart';

abstract class Provider<State> extends InheritedWidget {
  const Provider({
    required this.state,
    required this.onStateChanged,
    required Widget child,
    Key? key,
  }) : super(
          child: child,
          key: key,
        );

  final State state;
  final ValueChanged<State> onStateChanged;

  void emit(State state) {
    if (this.state != state) {
      onStateChanged(state);
    }
  }

  @override
  bool updateShouldNotify(covariant Provider<State> oldWidget) {
    return oldWidget.state != state ||
        oldWidget.onStateChanged != onStateChanged;
  }
}

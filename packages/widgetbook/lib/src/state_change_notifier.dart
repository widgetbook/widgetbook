import 'package:flutter/material.dart';

class StateChangeNotifier<T> with ChangeNotifier {
  StateChangeNotifier({
    required T state,
  }) : _state = state;

  T _state;

  set state(T value) {
    if (state == value) {
      return;
    }

    _state = value;
    notifyListeners();
  }

  T get state => _state;
}

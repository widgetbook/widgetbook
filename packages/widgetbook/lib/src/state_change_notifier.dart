import 'package:flutter/material.dart';

class StateChangeNotifier<T> with ChangeNotifier {
  StateChangeNotifier({
    required T state,
  }) : _state = state;

  T _state;

  set state(T value) {
    _state = value;
    notifyListeners();
  }

  T get state => _state;
}

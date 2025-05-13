import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import 'knob.dart';

class KnobsRegistry extends ChangeNotifier with MapMixin<String, Knob> {
  KnobsRegistry({
    required this.onLock,
  });

  final Map<String, Knob> _registry = {};
  final VoidCallback onLock;

  @internal
  void lock() {
    notifyListeners();
    onLock();
  }

  @internal
  T? register<T>(
    Knob<T?> knob,
    Map<String, String> queryGroup,
  ) {
    _registry.putIfAbsent(knob.label, () => knob);

    return knob.valueFromQueryGroup(queryGroup);
  }

  @Deprecated(
    'Knobs values can no longer be updated, '
    'they rely on query groups.',
  )
  void updateValue<T>(String label, T value) {}

  @override
  Knob? operator [](Object? key) => _registry[key as String];

  @override
  void operator []=(String key, Knob value) => _registry[key] = value;

  @override
  Iterable<String> get keys => _registry.keys;

  @override
  void clear() => _registry.clear();

  @override
  Knob? remove(Object? key) => _registry.remove(key);
}

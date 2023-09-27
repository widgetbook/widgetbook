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
    final cachedKnob = _registry.putIfAbsent(
      knob.label,
      () => knob,
    );

    // Return `null` even if the knob has value, but it was marked as null
    // using [updateNullability].
    if (cachedKnob.isNullable && cachedKnob.isNull) return null;

    // Get value from query group
    return knob.valueFromQueryGroup(queryGroup);
  }

  /// Updates [Knob.value] using the [label] to find the [Knob].
  void updateValue<T>(String label, T value) {
    _registry.update(
      label,
      (knob) => knob..value = value,
    );

    notifyListeners();
  }

  /// Updates [Knob.isNull] using the [label] to find the [Knob].
  @internal
  void updateNullability(String label, bool isNull) {
    _registry.update(
      label,
      (knob) => knob..isNull = isNull,
    );

    notifyListeners();
  }

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

import 'dart:collection';

import 'package:flutter/foundation.dart';
// ignore: unnecessary_import flutter(<3.35.0)
import 'package:meta/meta.dart';

import 'knob.dart';

/// The [KnobsRegistry] is a registry for [Knob]s that allows you to register
/// and retrieve knobs by their label.
/// After all knobs are registered, the [lock] method should be called,
/// which will trigger the [onLock] callback.
class KnobsRegistry extends ChangeNotifier with MapMixin<String, Knob> {
  /// Creates a new instance of [KnobsRegistry].
  KnobsRegistry({
    required this.onLock,
  });

  final Map<String, Knob> _registry = {};

  /// Callback that is called when the knobs are locked.
  /// Used to notify listeners that all use-case's knobs have been registered.
  final VoidCallback onLock;

  /// Locks the knobs registry and notifies listeners.
  /// This should be called after all knobs are registered.
  @internal
  void lock() {
    notifyListeners();
    onLock();
  }

  /// Registers a [Knob] and retrieves its value based on the [queryGroup].
  @internal
  T? register<T>(
    Knob<T?> knob,
    Map<String, String> queryGroup,
  ) {
    _registry[knob.label] = knob;

    return knob.valueFromQueryGroup(queryGroup);
  }

  /// No-op method.
  /// Just present to maintain compatibility with the old API.
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

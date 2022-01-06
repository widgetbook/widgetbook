import 'package:meta/meta.dart';

@immutable

/// The most basic form of an Instance.
/// Defines a [toCode] function.
abstract class BaseInstance {
  /// Const constructor for BaseInstance
  const BaseInstance();

  /// Transforms the [BaseInstance] or its implementation into Code (a String)
  ///
  /// This makes testing rather easy, because the building blocs of a whole
  /// Code tree can be easily tested, but just testing the underlying
  /// types of instances.
  /// More complex implementations of Instances can be based on the
  /// BaseInstances for which only the configuration (properties, etc) have to
  /// be unit tested since the [toCode] function is inherited.
  String toCode();
}

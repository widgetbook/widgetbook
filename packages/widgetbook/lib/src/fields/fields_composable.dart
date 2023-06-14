import 'package:flutter/widgets.dart';

import 'field.dart';

/// Interface for defining APIs for features that
/// use [fields] as a building block.
abstract class FieldsComposable<T> {
  List<Field> get fields;

  /// Converts a query group to a value of type [T].
  T valueFromQueryGroup(Map<String, String> group);

  /// Converts the [fields] into a [Widget] that will be rendered in the
  /// settings side panel.
  Widget buildFields(BuildContext context);
}

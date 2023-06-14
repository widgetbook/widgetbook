import 'package:flutter/widgets.dart';

import 'field.dart';

abstract class FieldsComposable<T> {
  List<Field> get fields;

  /// Converts a query group to a setting of type [T].
  T valueFromQueryGroup(Map<String, String> group);

  /// Converts the [fields] into a [Widget] that will be rendered in the
  /// settings side panel.
  Widget buildFields(BuildContext context);
}

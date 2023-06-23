import 'package:flutter/widgets.dart';

import 'field.dart';
import 'field_codec.dart';

/// Interface for defining APIs for features that
/// use [fields] as a building block.
abstract class FieldsComposable<T> {
  List<Field> get fields;

  /// Converts a query group to a value of type [T].
  T valueFromQueryGroup(Map<String, String> group);

  /// Converts the [fields] into a [Widget] that will be rendered in the
  /// settings side panel.
  Widget buildFields(BuildContext context);

  /// Decodes the value of the [Field] with [name] from the query [group]
  /// using the [FieldCodec.toValue] from [Field.codec].
  TField? valueOf<TField>(String name, Map<String, String> group) {
    final field = fields.firstWhere(
      (field) => field.name == name,
    ) as Field<TField>;

    return field.valueFrom(group);
  }

  Map<String, dynamic> toJson();
}

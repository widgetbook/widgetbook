import 'package:flutter/widgets.dart';

import '../routing/routing.dart';
import '../settings/settings.dart';
import 'field.dart';
import 'field_codec.dart';

/// A [FieldsComposable] is a collection or a group of [Field]s that can be used
/// to create a settings panel in Widgetbook. Each field in the group should have
/// a unique [name] and can be used to configure addons or knobs.
abstract class FieldsComposable<T> {
  /// Creates a [FieldsComposable] with the specified configuration.
  const FieldsComposable({
    required this.name,
    this.description,
    this.isNullable = false,
  });

  /// The display name of the composable group.
  final String name;

  /// The description of the composable group.
  final String? description;

  /// Whether this composable group is nullable.
  final bool isNullable;

  /// The name of the query group param.
  String get groupName;

  /// A list of [Field]s that belong to this composable group.
  List<Field> get fields;

  /// Converts the [name] to a slugified version that can be used in query
  /// parameters.
  String slugify(String name) {
    return name.trim().toLowerCase().replaceAll(RegExp(' '), '-');
  }

  /// Converts a query group to a value of type [T].
  T valueFromQueryGroup(QueryGroup group) {
    if (fields.length > 1) {
      throw UnimplementedError(
        '$runtimeType needs to implement `valueFromQueryGroup`. '
        'The default implementation only only works '
        'for composables with a single field.',
      );
    }

    final field = fields.first;
    return field.valueFrom(group) as T;
  }

  /// Converts a value of type [T] to a query group.
  QueryGroup valueToQueryGroup(T value) {
    return {
      for (final field in fields) field.name: paramOf(field.name, value),
    };
  }

  /// Converts the [fields] into a [Widget] that will be rendered in the
  /// settings side panel.
  Widget buildFields(BuildContext context) {
    final child = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          fields
              .map(
                (field) => Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4.0,
                  ),
                  child: field.build(context, groupName),
                ),
              )
              .toList(),
    );

    // TODO: implement nullable composables
    return Setting(
      name: name,
      description: description,
      child: child,
    );
  }

  /// Decodes the value of the [Field] with [name] from the query [group]
  /// using the [FieldCodec.toValue] from [Field.codec].
  TField? valueOf<TField>(String name, QueryGroup group) {
    final field =
        fields.firstWhere(
              (field) => field.name == name,
            )
            as Field<TField>;

    return field.valueFrom(group);
  }

  /// Encodes the value of the [Field] with [name] to a query parameter.
  String paramOf<TField>(String name, TField value) {
    final field =
        fields.firstWhere(
              (field) => field.name == name,
            )
            as Field<TField>;

    return field.codec.toParam(value);
  }
}

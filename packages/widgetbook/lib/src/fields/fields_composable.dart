import 'package:flutter/widgets.dart';

import '../routing/routing.dart';
import '../settings/settings.dart';
import '../state/state.dart';
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
    required this.initialValue,
  });

  /// The display name of the composable group.
  final String name;

  /// The description of the composable group.
  final String? description;

  /// The initial value of the composable group.
  final T initialValue;

  /// The name of the query group param.
  String get groupName;

  /// A list of [Field]s that belong to this composable group.
  List<Field> get fields;

  /// Whether this composable group is nullable.
  bool get isNullable => null is T;

  /// Converts the [name] to a slugified version that can be used in query
  /// parameters.
  String slugify(String name) {
    return name.trim().toLowerCase().replaceAll(RegExp(' '), '-');
  }

  /// Converts a query group to a value of type [T].
  /// [group] can be null if there is no query parameter for this group.
  T valueFromQueryGroup(QueryGroup? group) {
    if (fields.length > 1) {
      throw UnimplementedError(
        '$runtimeType needs to implement `valueFromQueryGroup`. '
        'The default implementation only only works '
        'for composables with a single field.',
      );
    }

    if (group == null) return initialValue;

    // T has to be a nullable type if the group is nullified
    // to be able to return null.
    if (isNullable && group.isNullified) return null as T;

    final field = fields.first;
    return field.valueFrom(group) as T;
  }

  /// Converts a value of type [T] to a query group.
  QueryGroup valueToQueryGroup(T value) {
    return QueryGroup(
      isNullified: isNullable && value == null,
      {
        for (final field in fields) field.name: paramOf(field.name, value),
      },
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

    if (!isNullable) {
      return Setting(
        name: name,
        description: description,
        child: child,
      );
    }

    final state = WidgetbookState.of(context);
    final group = state.queryGroups[groupName];

    // If the query group is not present, we delegate the check to
    // valueFromQueryGroup, which can have custom implementation,
    // to determine nullability based on the value.
    // If the query group is present, we check its nullability.
    final isNullified =
        group == null ? valueFromQueryGroup(null) == null : group.isNullified;

    return !isNullable
        ? Setting(
          name: name,
          description: description,
          child: child,
        )
        : NullableSetting(
          name: name,
          description: description,
          isNullified: isNullified,
          onNullified: (value) {
            if (group == null) {
              state.updateQueryGroup(groupName, QueryGroup.nullified);
              return;
            }

            final newGroup = value ? group.nullify() : group.unnullify();
            state.updateQueryGroup(groupName, newGroup);
          },
          child: child,
        );
  }
}

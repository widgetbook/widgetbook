import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';

import '../routing/routing.dart';
import '../settings/settings.dart';
import '../state/state.dart';
import 'field.dart';

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
  T valueFromQueryGroup(QueryGroup? group);

  /// Converts a value of type [T] to a query group.
  QueryGroup valueToQueryGroup(T value);

  /// Decodes the value of the [Field] with [name] from the query [group]
  /// using the [Field.toValue].
  TField valueOf<TField>(String name, QueryGroup group) {
    final field = fields.firstWhereOrNull(
      (field) => field.name == name,
    );

    if (field == null) {
      throw ArgumentError(
        'Field with name $name not found in $runtimeType.',
      );
    }

    return field.valueFrom(group) as TField;
  }

  /// Encodes the value of the [Field] with [name] to a query parameter
  /// using the [Field.toParam].
  String paramOf<TField>(String name, TField value) {
    final field = fields.firstWhereOrNull(
      (field) => field.name == name,
    );

    if (field == null) {
      throw ArgumentError(
        'Field with name $name not found in $runtimeType.',
      );
    }

    // Need to cast the Field<dynamic> to Field<TField>
    // to be able to safely call `toParam` without type issues.
    final safeField = field as Field<TField>;

    return safeField.toParam(value);
  }

  /// Converts the [fields] into a [Widget] that will be rendered in the
  /// settings side panel.
  Widget buildFields(BuildContext context) {
    final state = WidgetbookState.of(context);
    final group = state.queryGroups[groupName];

    final child = Column(
      // This key is needed to force rebuilds when the args are updated
      // using `Arg.update`.
      key: group != null ? ValueKey(group) : null,
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

    // If the query group is not present, we delegate the check to
    // valueFromQueryGroup, which can have custom implementation,
    // to determine nullability based on the value.
    // If the query group is present, we check its nullability.
    final isNullified =
        group == null ? valueFromQueryGroup(null) == null : group.isNullified;

    return NullableSetting(
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

/// Provides a default implementation for [FieldsComposable]s that
/// consist of a single [Field] only.
mixin SingleFieldOnly<T> on FieldsComposable<T> {
  Field<T> get field;

  @override
  List<Field> get fields => [field];

  /// Converts a query group to a value of type [T].
  /// [group] can be null if there is no query parameter for this group.
  T valueFromQueryGroup(QueryGroup? group) {
    if (group == null) return initialValue;

    // T has to be a nullable type if the group is nullified
    // to be able to return null.
    if (isNullable && group.isNullified) return null as T;

    return field.valueFrom(group);
  }

  /// Converts a value of type [T] to a query group.
  QueryGroup valueToQueryGroup(T value) {
    if (isNullable && value == null) {
      return QueryGroup.nullified;
    }

    return QueryGroup(
      // We need to use the `unsafeToParam` method to avoid type issues
      // since T can be nullable, and `toParam` expects a non-nullable type.
      // This can cause issues like:
      // type '(int) => String' is not a subtype of type '(int?) => String'
      // even if the value is guaranteed to be non-null here.
      {field.name: field.$unsafeToParam(value)},
    );
  }
}

/// A mixin that provides an empty implementation for [FieldsComposable]s
/// that do not have any fields.
mixin NoFields<T> on FieldsComposable<T> {
  @override
  List<Field> get fields => [];

  @override
  T valueFromQueryGroup(QueryGroup? group) => initialValue;

  @override
  QueryGroup valueToQueryGroup(T value) => QueryGroup.empty;
}

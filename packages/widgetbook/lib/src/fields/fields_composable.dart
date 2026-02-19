import 'package:flutter/widgets.dart';

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
    this.isNullable = false,
    this.defaultToNull = false,
  });

  /// The display name of the composable group.
  final String name;

  /// The description of the composable group.
  final String? description;

  /// Whether this composable group is nullable.
  final bool isNullable;

  /// When true, the nullable composable will start with the checkbox unchecked
  /// (resolving to null) even if a non-null initial value is provided.
  /// This allows setting a default value that is shown when the checkbox is
  /// checked, while starting in the unchecked/null state.
  ///
  /// This parameter is ignored when [isNullable] is false or when the
  /// initial value is null.
  final bool defaultToNull;

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
  T valueFromQueryGroup(Map<String, String> group);

  /// Converts the [fields] into a [Widget] that will be rendered in the
  /// settings side panel.
  Widget buildFields(BuildContext context) {
    final child = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: fields
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

    return !isNullable
        ? Setting(
            name: name,
            description: description,
            child: child,
          )
        : NullableSetting(
            name: name,
            description: description,
            isNullified: isNullified(context),
            onNullified: (isNullified) => toggleNullification(
              context,
              nullify: isNullified,
            ),
            child: child,
          );
  }

  /// Decodes the value of the [Field] with [name] from the query [group]
  /// using the [FieldCodec.toValue] from [Field.codec].
  TField? valueOf<TField>(String name, Map<String, String> group) {
    final field =
        fields.firstWhere(
              (field) => field.name == name,
            )
            as Field<TField>;

    // If defaultToNull is true, the group is empty (first load),
    // and we're nullable, return null instead of the initialValue
    if (defaultToNull && isNullable && group.isEmpty) {
      return null;
    }

    return field.valueFrom(group);
  }

  /// Whether the group has been nullified by [toggleNullification].
  bool isNullified(BuildContext context) {
    final state = WidgetbookState.of(context);
    final groupMap = FieldCodec.decodeQueryGroup(
      state.queryParams[groupName],
    );

    // If defaultToNull is true and the field hasn't been interacted with yet,
    // start in the nullified state
    if (defaultToNull && isNullable) {
      final hasFieldInQuery = fields.any(
        (field) => groupMap.containsKey(field.name),
      );

      // If no field has been set in the query params, start nullified
      if (groupMap.isEmpty || !hasFieldInQuery) return true;
    }

    return fields.every(
      (field) => field.valueFrom(groupMap) == null,
    );
  }

  /// Adds/removes [Field.nullabilitySymbol] to/from all [fields] depending on
  /// the [nullify] state.
  /// If [nullify] is `true`, the [Field.nullabilitySymbol] is added.
  /// If [nullify] is `false`, the [Field.nullabilitySymbol] is removed.
  @protected
  void toggleNullification(
    BuildContext context, {
    required bool nullify,
  }) {
    assert(
      isNullable,
      'toggleNullification is only available for nullable composables',
    );

    // NOTE:
    // Currently, we are nullifying the [FieldsComposable] by nullifying all
    // the fields in the group. A better approach would be by nullifying the
    // group itself only (for example: `group={...}` > `group=?{...}).
    // This approach is not currently feasible as all knobs are located under
    // the same group. This is a limitation of the current implementation.
    // We can revisit in future major releases.

    final state = WidgetbookState.of(context);
    final groupMap = FieldCodec.decodeQueryGroup(
      state.queryParams[groupName],
    );

    fields.forEach((field) {
      // If the field is not present in the `groupMap`, we set it to its
      // initial value or default value.
      //
      // This is used when user first interacts with a nullable field.
      if (!groupMap.containsKey(field.name)) {
        final value =
            field.initialValueStringified ?? field.defaultValueStringified;
        state.updateQueryField(
          group: groupName,
          field: field.name,
          value: nullify ? '${Field.nullabilitySymbol}${value}' : value,
        );
        return;
      }

      final value = groupMap[field.name];
      if (value == null) return;

      final rawValue = value.replaceFirst(Field.nullabilitySymbol, '');
      final nullishValue = '${Field.nullabilitySymbol}$rawValue';

      state.updateQueryField(
        group: groupName,
        field: field.name,
        value: nullify ? nullishValue : rawValue,
      );
    });
  }

  /// Converts this composable group to a JSON representation.
  Map<String, dynamic> toJson();
}

import 'package:flutter/widgets.dart';

import '../../fields/fields.dart';
import '../../settings/settings.dart';
import '../experimental_badge.dart';
import 'const_arg.dart';

@optionalTypeArgs
abstract class Arg<T> extends FieldsComposable<T> {
  const Arg(
    T value, {
    String? name,
  })  : $value = value,
        $name = name;

  const Arg.empty()
      : $value = null,
        $name = null;

  final T? $value;
  final String? $name;

  T get value => $value!;

  String get name {
    // A safe way to access [$name] in a non-nullable behavior for simplicity.
    // The name should ne provided via constructor or init method.
    assert(
      $name != null,
      'Name must be set via constructor or init method',
    );

    return $name!;
  }

  /// Creates a copy of this using the provided [name] for late initialization.
  /// If [$name] was already set, it should have precedence over [name].
  ///
  /// Example:
  /// Arg(0).init(name: 'integer') => Arg(0, name: 'integer')
  /// Arg(0, name: 'int').init(name: 'integer') => Arg(0, name: 'int')
  Arg<T> init({
    required String name,
  });

  static ConstArg<T> fixed<T>(T value) => ConstArg<T>(value);

  @override
  String get groupName => 'args';

  @override
  Widget buildFields(BuildContext context) {
    return Setting(
      name: name,
      trailing: const ExperimentalBadge(),
      child: Column(
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
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'group': groupName,
      'fields': fields.map((field) => field.toFullJson()).toList(),
    };
  }
}

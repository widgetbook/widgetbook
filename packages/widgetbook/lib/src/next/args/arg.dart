import 'package:flutter/widgets.dart';

import '../../fields/fields.dart';
import '../../settings/settings.dart';
import '../experimental_badge.dart';
import 'const_arg.dart';

@optionalTypeArgs
abstract class Arg<T> extends FieldsComposable<T> {
  const Arg({
    this.name = '<unknown>',
    required this.value,
  });

  final String name;
  final T value;

  @override
  String get groupName => 'args';

  Arg<T> init({
    required String name,
  });

  static ConstArg<T> of<T>(T value) => ConstArg<T>(value);

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

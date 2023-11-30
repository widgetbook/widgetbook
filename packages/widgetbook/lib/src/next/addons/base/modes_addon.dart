import 'package:flutter/widgets.dart';

import '../../../../widgetbook.dart';
import '../../../settings/settings.dart';
import '../../experimental_badge.dart';
import 'mode.dart';

/// TODO: replace extending WidgetbookAddon with FieldComposable
///  Currently, it is designed this way to keep compatibility with
///  Widgetbook v3
abstract class ModesAddon<T extends Mode<dynamic>> extends WidgetbookAddon<T> {
  ModesAddon({
    required super.name,
    required this.modes,
  });

  final List<T> modes;

  @override
  Widget buildUseCase(BuildContext context, Widget child, T setting) {
    return setting.build(context, child);
  }

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

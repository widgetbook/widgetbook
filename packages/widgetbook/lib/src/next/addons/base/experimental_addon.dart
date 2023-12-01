import 'package:flutter/widgets.dart';

import '../../../settings/settings.dart';
import '../../experimental_badge.dart';
import 'addon.dart';

/// Adds the experimental badge to the addon
mixin ExperimentalAddon<T> on Addon<T> {
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
}

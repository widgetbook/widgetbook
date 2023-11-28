import 'package:flutter/material.dart';

import '../../../widgetbook.dart';
import '../../settings/setting.dart';
import '../experimental_badge.dart';

// TODO: convert to abstract class
//  currently it is created as mixin, to allow compatibility between
//  WidgetbookAddon<T> and Mode<T>
mixin Mode<T> on WidgetbookAddon<T> {
  @override
  String get groupName {
    // To temporarily avoid conflicts with other addons.
    return super.groupName + '-mode';
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
}

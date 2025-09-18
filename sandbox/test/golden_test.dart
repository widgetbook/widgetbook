import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:sandbox/components.book.dart';
import 'package:sandbox/widgetbook.config.dart';

void main() {
  for (final component in components) {
    for (final story in component.stories) {
      for (final scenario in story.scenarios) {
        final name = '${component.name}/${story.$name}/${scenario.name}';

        goldenTest(
          name,
          fileName: name,
          builder: () => Builder(
            builder: (context) {
              // Re-use app builder from config
              return config.appBuilder(
                context,
                story.buildWithScenario(context, scenario),
              );
            },
          ),
        );
      }
    }
  }
}

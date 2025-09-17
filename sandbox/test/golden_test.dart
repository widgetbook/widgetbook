import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:sandbox/[sam]/types_table.dart';
import 'package:sandbox/[sam]/types_table.stories.dart';
import 'package:sandbox/widgetbook.config.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  goldenTest(
    '${TypesTableComponent.name} renders correctly',
    fileName: TypesTableComponent.name,
    constraints: const BoxConstraints.expand(
      width: 1200,
      height: 1400,
    ),
    builder: () => Builder(
      builder: (context) {
        // Re-use app builder from config
        return config.appBuilder(
          context,
          GoldenTestGroup(
            children: [
              TypesTableScenario(
                name: 'Default',
                story: $Default,
              ),
              TypesTableScenario(
                name: 'Default',
                story: $Default,
                args: TypesTableArgs.fixed(
                  person: const Person(
                    name: 'John Doe',
                    age: 42,
                  ),
                  child: const Text('Hello World'),
                ),
              ),
              TypesTableScenario(
                name: 'Default - Dark',
                story: $Default,
                modes: [MaterialThemeMode(ThemeData.dark())],
              ),
              TypesTableScenario(
                name: 'Default - Light',
                story: $Default,
                modes: [MaterialThemeMode(ThemeData.light())],
              ),
            ],
          ),
        );
      },
    ),
  );
}

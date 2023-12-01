import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:sandbox/next/types_table.dart';
import 'package:sandbox/next/types_table.stories.dart';
import 'package:widgetbook/next.dart';

void main() {
  goldenTest(
    '${TypesTableComponent.name} renders correctly',
    fileName: TypesTableComponent.name,
    constraints: const BoxConstraints.expand(
      width: 1200,
      height: 1400,
    ),
    builder: () => MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GoldenTestGroup(
        children: [
          TypesTableScenario(
            name: 'Default',
            story: $Default,
          ),
          TypesTableScenario(
            name: 'Default',
            story: $Default,
            args: TypesTableArgs(
              person: Arg.fixed(
                const Person(
                  name: 'John Doe',
                  age: 42,
                ),
              ),
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
    ),
  );
}

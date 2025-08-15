// ignore_for_file: deprecated_member_use analyzer(<8.0.0)

import 'package:analyzer/dart/element/element2.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';

import 'extensions.dart';

class ComponentBuilder {
  ComponentBuilder(
    this.widgetType,
    this.argsType,
    this.stories,
  );

  final DartType widgetType;
  final DartType argsType;
  final List<TopLevelVariableElement2> stories;

  Code build() {
    return declareFinal('${widgetType.nonNullableName}Component')
        .assign(
          InvokeExpression.newOf(
            TypeReference(
              (b) =>
                  b
                    ..symbol =
                        stories.length == 1 ? 'LeafComponent' : 'Component'
                    ..types.addAll([
                      refer(widgetType.nonNullableName),
                      refer('${argsType.nonNullableName}Args'),
                    ]),
            ),
            [],
            {
              'meta': refer('meta'),
              if (stories.length == 1)
                'story': refer(stories.first.displayName)
              else
                'stories': literalList(
                  stories.map((story) => refer(story.displayName)).toList(),
                ),
            },
          ),
        )
        .statement;
  }
}

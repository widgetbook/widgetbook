import 'package:analyzer/dart/element/element.dart';
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
  final List<TopLevelVariableElement> stories;

  Code build() {
    return declareFinal('${widgetType.displayName}Component')
        .assign(
          InvokeExpression.newOf(
            TypeReference(
              (b) => b
                ..symbol = stories.length == 1 ? 'LeafComponent' : 'Component'
                ..types.addAll([
                  refer(widgetType.displayName),
                  refer('${argsType.displayName}Args'),
                ]),
            ),
            [],
            {
              'meta': refer('meta'),
              if (stories.length == 1)
                'story': refer(stories.first.name)
              else
                'stories': literalList(
                  stories.map((story) => refer(story.name)).toList(),
                ),
            },
          ),
        )
        .statement;
  }
}

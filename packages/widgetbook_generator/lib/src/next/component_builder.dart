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
    return declareFinal('${widgetType.nonNullableName}Component')
        .assign(
          InvokeExpression.newOf(
            TypeReference(
              (b) => b
                ..symbol = 'Component'
                ..types.addAll([
                  refer(widgetType.nonNullableName),
                  refer('${argsType.nonNullableName}Args'),
                ]),
            ),
            [],
            {
              'meta': refer('meta'),
              'stories': literalList(
                stories.map((story) => refer(story.name)).toList(),
              ),
            },
          ),
        )
        .statement;
  }
}

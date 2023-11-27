import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';

import 'extensions.dart';

class ComponentBuilder {
  ComponentBuilder(
    this.type,
    this.stories,
  );

  final DartType type;
  final List<TopLevelVariableElement> stories;

  Code build() {
    return declareFinal('${type.displayName}Component')
        .assign(
          InvokeExpression.newOf(
            refer('WidgetbookComponent<${type.displayName}>'),
            [],
            {
              'metadata': refer('metadata'),
              'stories': literalList(
                stories.map((story) => refer(story.name)).toList(),
              ),
            },
          ),
        )
        .statement;
  }
}

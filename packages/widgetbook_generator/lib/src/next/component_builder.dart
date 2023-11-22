import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';

class ComponentBuilder {
  ComponentBuilder(
    this.type,
    this.stories,
  );

  final DartType type;
  final List<TopLevelVariableElement> stories;

  String get name {
    return type.getDisplayString(withNullability: false);
  }

  Code build() {
    return declareFinal('${name}Component')
        .assign(
          InvokeExpression.newOf(
            refer('WidgetbookComponent<$name>'),
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

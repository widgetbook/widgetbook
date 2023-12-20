import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';
import 'package:path/path.dart' as p;

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
              'meta': refer('meta').property('init').call(
                [],
                {'path': literalString(navPath)},
              ),
              'stories': literalList(
                stories.map((story) => refer(story.name)).toList(),
              ),
            },
          ),
        )
        .statement;
  }

  /// Gets the navigation path based on [widgetType], skipping both
  /// the `package:` and the `src` parts.
  ///
  /// For example, `package:my_app/src/widgets/foo/bar.dart`
  /// will be converted to `widgets/foo`.
  String get navPath {
    final uri = widgetType.element!.source!.uri.toString();
    final directory = p.dirname(uri);
    final parts = p.split(directory);
    final hasSrc = parts.length >= 2 && parts[1] == 'src';

    return parts.skip(hasSrc ? 2 : 1).join('/');
  }
}

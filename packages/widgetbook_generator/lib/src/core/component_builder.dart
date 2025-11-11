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
    this.path,
  );

  final DartType widgetType;
  final DartType argsType;
  final List<TopLevelVariableElement> stories;
  final String path;

  TypeDef buildUnderscoreType() {
    return TypeDef(
      (b) => b
        ..name = '_Component'
        ..definition = TypeReference(
          (b) => b
            ..symbol = 'Component'
            ..types.addAll([
              refer(widgetType.nonGenericName),
              refer('${argsType.nonGenericName}Args'),
            ]),
        ),
    );
  }

  Code build() {
    return declareFinal('${widgetType.nonGenericName}Component')
        .assign(
          InvokeExpression.newOf(
            TypeReference(
              (b) => b
                ..symbol = 'Component'
                ..types.addAll([
                  refer(widgetType.nonGenericName),
                  refer('${argsType.nonGenericName}Args'),
                ]),
            ),
            [],
            {
              'name': refer('meta')
                  .property('name')
                  .ifNullThen(
                    literalString(widgetType.nonGenericName),
                  ),
              'path': refer('meta')
                  .property('path')
                  .ifNullThen(
                    literalString(navPath),
                  ),
              'docs': refer('meta').property('docs'),
              'stories': literalList(
                stories
                    .map(
                      (story) => refer(story.displayName)
                          .cascade(r'$generatedName')
                          .assign(
                            literalString(
                              story.displayName.replaceFirst(r'$', ''),
                            ),
                          ),
                    )
                    .toList(),
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
    final directory = p.dirname(path);
    final parts = p.split(directory);
    final hasSrc = parts.length >= 2 && parts[1] == 'src';

    return parts.skip(hasSrc ? 2 : 1).join('/');
  }
}

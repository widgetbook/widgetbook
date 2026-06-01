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
    this.constructorName, {
    this.isMultiMeta = false,
  });

  final DartType widgetType;
  final DartType argsType;
  final List<TopLevelVariableElement> stories;
  final String path;
  final String? constructorName;

  /// When `true`, the file declares more than one `Meta<TWidget>` variable
  /// (one per constructor variant). The generated component aggregates all
  /// stories under a single `${Widget}Component` typed as
  /// `Component<TWidget, StoryArgs<TWidget>>` so it can hold heterogeneous
  /// stories whose args classes differ per constructor.
  final bool isMultiMeta;

  TypeReference get _componentTypeRef {
    return TypeReference(
      (b) => b
        ..symbol = 'Component'
        ..types.addAll([
          refer(widgetType.nonGenericName),
          if (isMultiMeta)
            refer('StoryArgs<${widgetType.nonGenericName}>')
          else
            refer('${argsType.nonGenericName}Args'),
        ]),
    );
  }

  TypeDef buildUnderscoreType() {
    return TypeDef(
      (b) => b
        ..name = '_Component'
        ..definition = _componentTypeRef,
    );
  }

  String get _capitalizedConstructorName {
    if (constructorName == null) return '';
    return constructorName![0].toUpperCase() + constructorName!.substring(1);
  }

  String get _componentVariableName {
    // Multi-meta files emit a single component per widget; the constructor
    // name is not part of the variable name.
    final suffix = isMultiMeta ? '' : _capitalizedConstructorName;
    return '${widgetType.nonGenericName}${suffix}Component';
  }

  String get _defaultComponentName {
    final baseName = widgetType.nonGenericName;
    if (constructorName == null || isMultiMeta) return baseName;
    return '$baseName.$constructorName';
  }

  Code build() {
    return declareFinal(_componentVariableName)
        .assign(
          InvokeExpression.newOf(
            _componentTypeRef,
            [],
            {
              'name': refer('meta')
                  .property('name')
                  .ifNullThen(
                    literalString(_defaultComponentName),
                  ),
              'path': refer('meta')
                  .property('path')
                  .ifNullThen(
                    literalString(navPath),
                  ),
              'docsBuilder': refer(
                'meta',
              ).property('docsBuilder'),
              'docComment': widgetType.element?.documentationComment != null
                  ? CodeExpression(
                      Code(
                        "r'''"
                        "${widgetType.element!.documentationComment!.replaceAll(RegExp(r'/// ?'), '')}"
                        "'''",
                      ),
                    )
                  : literalNull,
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

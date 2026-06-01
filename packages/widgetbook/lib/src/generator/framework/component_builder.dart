import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';
import 'package:path/path.dart' as p;

import 'extensions.dart';

class ComponentBuilder {
  ComponentBuilder(this.widgetType, this.stories, this.path);

  final DartType widgetType;
  final List<TopLevelVariableElement> stories;
  final String path;

  /// The generated component always uses `Component<TWidget, StoryArgs<TWidget>>`
  /// so it can hold stories whose args classes differ per constructor. One
  /// file produces one component per widget; the constructor (if any) is
  /// reflected in the per-meta Args/Story classes, not in the component
  /// variable or nav label.
  TypeReference get _componentTypeRef {
    return TypeReference(
      (b) => b
        ..symbol = 'Component'
        ..types.addAll([
          refer(widgetType.nonGenericName),
          refer('StoryArgs<${widgetType.nonGenericName}>'),
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

  Code build() {
    final widgetName = widgetType.nonGenericName;

    return declareFinal('${widgetName}Component')
        .assign(
          InvokeExpression.newOf(
            _componentTypeRef,
            [],
            {
              'name': refer('meta')
                  .property('name')
                  .ifNullThen(
                    literalString(widgetName),
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

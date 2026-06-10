import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';
import 'package:path/path.dart' as p;

import 'extensions.dart';

class ComponentBuilder {
  ComponentBuilder(
    this.widgetType,
    this.stories,
    this.path,
    this.metaVariableName,
  );

  final DartType widgetType;
  final List<TopLevelVariableElement> stories;
  final String path;

  /// The name of the top-level `ComponentMeta` variable, referenced in the
  /// generated component for name/path/docsBuilder overrides.
  /// Null if the stories file defines no `ComponentMeta`; the defaults are
  /// then emitted directly.
  final String? metaVariableName;

  /// The component is typed with the args base class instead of a generated
  /// args class, as its stories can come from different variants, each with
  /// its own args class.
  TypeReference get componentTypeRef {
    return TypeReference(
      (b) => b
        ..symbol = 'Component'
        ..types.addAll([
          refer(widgetType.nonGenericName),
          TypeReference(
            (b) => b
              ..symbol = 'StoryArgs'
              ..types.add(refer(widgetType.nonGenericName)),
          ),
        ]),
    );
  }

  TypeDef buildUnderscoreType() {
    return TypeDef(
      (b) => b
        ..name = '_Component'
        ..definition = componentTypeRef,
    );
  }

  Code build() {
    final metaVariableName = this.metaVariableName;

    return declareFinal('${widgetType.nonGenericName}Component')
        .assign(
          InvokeExpression.newOf(
            componentTypeRef,
            [],
            {
              'name': metaVariableName == null
                  ? literalString(widgetType.nonGenericName)
                  : refer(metaVariableName)
                        .property('name')
                        .ifNullThen(
                          literalString(widgetType.nonGenericName),
                        ),
              'path': metaVariableName == null
                  ? literalString(navPath)
                  : refer(metaVariableName)
                        .property('path')
                        .ifNullThen(
                          literalString(navPath),
                        ),
              if (metaVariableName != null)
                'docsBuilder': refer(
                  metaVariableName,
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

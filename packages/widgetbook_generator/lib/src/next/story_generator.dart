import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';
import 'package:source_gen/source_gen.dart';

class StoryGenerator extends Generator {
  @override
  Future<String> generate(
    LibraryReader library,
    BuildStep buildStep,
  ) async {
    final metadataVariable = library.allElements
        .whereType<TopLevelVariableElement>()
        .firstWhere((element) => element.name == 'metadata');

    final widgetType = metadataVariable
        .computeConstantValue()!
        .getField('type')!
        .toTypeValue()!;

    final widgetName = widgetType.getDisplayString(
      withNullability: false,
    );

    final widgetClass = widgetType.element as ClassElement;
    final widgetArgs = widgetClass.constructors.first.parameters;

    final storyDef = buildStoryClass(widgetName);
    final argsDef = buildArgsClass(widgetName, widgetArgs);

    final genLib = Library(
      (b) => b
        ..body.addAll(
          [
            storyDef,
            argsDef,
          ],
        ),
    );

    return genLib.accept(DartEmitter()).toString();
  }

  Class buildArgsClass(String name, List<ParameterElement> args) {
    final argsWithoutKey = args.whereNot((arg) => arg.name == 'key');

    return Class(
      (b) => b
        ..name = '${name}Args'
        ..extend = refer('WidgetbookArgs<$name, ${name}Args>')
        ..fields.addAll(
          argsWithoutKey.map(
            (arg) => Field(
              (b) => b
                ..modifier = FieldModifier.final$
                ..name = arg.name
                ..type = refer(
                  'WidgetbookArg<${arg.type.getDisplayString(
                    withNullability: false,
                  )}>',
                ),
            ),
          ),
        )
        ..constructors.add(
          Constructor(
            (b) => b.optionalParameters.addAll(
              argsWithoutKey.map(
                (arg) => Parameter(
                  (b) => b
                    ..named = true
                    ..name = arg.name
                    ..toThis = true
                    ..required = true, // TODO: make optional
                ),
              ),
            ),
          ),
        )
        ..methods.addAll(
          [
            Method(
              (b) => b
                ..name = 'list'
                ..type = MethodType.getter
                ..returns = refer('List<WidgetbookArg>')
                ..annotations.add(refer('override'))
                ..lambda = true
                ..body = Code(
                  '[${argsWithoutKey.map((arg) => '${arg.name}').join(', ')}]',
                ),
            ),
            Method(
              (b) => b
                ..name = 'build'
                ..returns = refer('Widget')
                ..annotations.add(refer('override'))
                ..requiredParameters.add(
                  Parameter(
                    (b) => b
                      ..name = 'context'
                      ..type = refer('BuildContext'),
                  ),
                )
                ..requiredParameters.add(
                  Parameter(
                    (b) => b
                      ..name = 'group'
                      ..type = refer('Map<String, String>'),
                  ),
                )
                ..body = Block(
                  (b) => b
                    ..addExpression(
                      InvokeExpression.newOf(
                        refer(name),
                        argsWithoutKey
                            .where((arg) => arg.isPositional)
                            .map(
                              (arg) => refer('${arg.name}')
                                  .property('valueFromQueryGroup')
                                  .call([refer('group')]),
                            )
                            .toList(),
                        Map.fromEntries(
                          argsWithoutKey //
                              .where((arg) => arg.isNamed)
                              .map(
                                (arg) => MapEntry(
                                  arg.name,
                                  refer('${arg.name}')
                                      .property('valueFromQueryGroup')
                                      .call([refer('group')]),
                                ),
                              ),
                        ),
                      ).returned,
                    ),
                ),
            ),
          ],
        ),
    );
  }

  Class buildStoryClass(String name) {
    return Class(
      (b) => b
        ..name = '${name}Story'
        ..extend = refer('WidgetbookStory<$name, ${name}Args>')
        ..constructors.add(
          Constructor(
            (b) => b.optionalParameters
              ..add(
                Parameter(
                  (b) => b
                    ..named = true
                    ..name = 'name'
                    ..toSuper = true
                    ..required = true,
                ),
              )
              ..add(
                Parameter(
                  (b) => b
                    ..named = true
                    ..name = 'args'
                    ..toSuper = true
                    ..required = true, // TODO: make optional
                ),
              ),
          ),
        ),
    );
  }
}

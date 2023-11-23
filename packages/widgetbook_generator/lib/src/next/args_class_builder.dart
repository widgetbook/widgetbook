import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';

class ArgsClassBuilder {
  ArgsClassBuilder(this.type);

  final DartType type;

  String get name {
    return type.getDisplayString(withNullability: false);
  }

  List<ParameterElement> get args {
    final cla$$ = type.element as ClassElement;
    return cla$$.constructors.first.parameters;
  }

  List<ParameterElement> get argsWithoutKey {
    return args.whereNot((arg) => arg.name == 'key').toList();
  }

  Class build() {
    return Class(
      (b) => b
        ..name = '${name}Args'
        ..extend = refer('WidgetbookArgs<$name>')
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
                ..annotations.add(refer('override'))
                ..returns = refer('Widget')
                ..requiredParameters.addAll([
                  Parameter(
                    (b) => b
                      ..name = 'context'
                      ..type = refer('BuildContext'),
                  ),
                  Parameter(
                    (b) => b
                      ..name = 'group'
                      ..type = refer('Map<String, String>'),
                  ),
                ])
                ..body = Block(
                  (b) => b
                    ..addExpression(
                      InvokeExpression.newOf(
                        refer(name),
                        argsWithoutKey
                            .where((arg) => arg.isPositional)
                            .map(
                              (arg) => refer(arg.name)
                                  .property('valueFromQueryGroup')
                                  .call([refer('group')]),
                            )
                            .toList(),
                        argsWithoutKey //
                            .where((arg) => arg.isNamed)
                            .lastBy((arg) => arg.name)
                            .map(
                              (key, value) => MapEntry(
                                key,
                                refer(value.name)
                                    .property('valueFromQueryGroup')
                                    .call([refer('group')]),
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
}

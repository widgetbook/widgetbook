import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';

import 'arg_builder.dart';

class ArgsClassBuilder {
  ArgsClassBuilder(this.type);

  final DartType type;

  String get name {
    return type.getDisplayString(withNullability: false);
  }

  Iterable<ParameterElement> get params {
    return (type.element as ClassElement)
        .constructors
        .first
        .parameters
        .whereNot((param) => param.name == 'key');
  }

  InvokeExpression instantiate(
    Expression Function(ParameterElement) assigner,
  ) {
    return InvokeExpression.newOf(
      refer(name),
      params //
          .where((param) => param.isPositional)
          .map(assigner)
          .toList(),
      params //
          .where((param) => param.isNamed)
          .lastBy((param) => param.name)
          .map(
            (_, param) => MapEntry(
              param.name,
              assigner(param),
            ),
          ),
    );
  }

  Class build() {
    return Class(
      (b) => b
        ..name = '${name}Args'
        ..extend = refer('WidgetbookArgs<$name>')
        ..fields.addAll(
          params.map(
            (param) => ArgBuilder(param).buildField(),
          ),
        )
        ..constructors.add(
          Constructor(
            (b) => b
              ..constant = true
              ..optionalParameters.addAll(
                params.map(
                  (param) => ArgBuilder(param).buildParam(),
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
                ..body = literalList(
                  params.map(
                    (param) => refer(param.name),
                  ),
                ).code,
            ),
            Method(
              (b) => b
                ..name = 'buildReactive'
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
                ..body = instantiate(
                  (param) => refer(param.name)
                      .property('valueFromQueryGroup')
                      .call([refer('group')]),
                ).returned.statement,
            ),
            Method(
              (b) => b
                ..name = 'buildStatic'
                ..annotations.add(refer('override'))
                ..returns = refer('Widget')
                ..requiredParameters.add(
                  Parameter(
                    (b) => b
                      ..name = 'context'
                      ..type = refer('BuildContext'),
                  ),
                )
                ..body = instantiate(
                  (param) => refer(param.name).property('value'),
                ).returned.statement,
            ),
          ],
        ),
    );
  }
}

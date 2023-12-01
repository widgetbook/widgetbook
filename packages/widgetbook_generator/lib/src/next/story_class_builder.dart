import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';

import 'extensions.dart';

class StoryClassBuilder {
  StoryClassBuilder(this.type);

  final DartType type;

  Iterable<ParameterElement> get params {
    return (type.element as ClassElement)
        .constructors
        .first
        .parameters
        .whereNot((param) => param.name == 'key');
  }

  Class build() {
    final isPrimitiveArgs = params.every((param) => param.type.isPrimitive);

    return Class(
      (b) => b
        ..name = '${type.displayName}Story'
        ..extend = refer('Story<${type.displayName}>')
        ..constructors.add(
          Constructor(
            (b) {
              b.optionalParameters.addAll([
                Parameter(
                  (b) => b
                    ..name = 'name'
                    ..named = true
                    ..toSuper = true
                    ..required = true,
                ),
                Parameter(
                  (b) => b
                    ..name = 'args'
                    ..named = true
                    ..toSuper = !isPrimitiveArgs
                    ..required = !isPrimitiveArgs
                    ..type = !isPrimitiveArgs
                        ? null
                        : refer('${type.displayName}Args?'),
                ),
              ]);

              if (!isPrimitiveArgs) {
                return;
              }

              b.initializers.add(
                refer('super').call(
                  [],
                  {
                    'args': refer('args').ifNullThen(
                      refer('${type.displayName}Args()'),
                    ),
                  },
                ).code,
              );
            },
          ),
        ),
    );
  }
}

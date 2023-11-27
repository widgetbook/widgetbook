import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';

import 'extensions.dart';

class StoryClassBuilder {
  StoryClassBuilder(this.type);

  final DartType type;

  Class build() {
    return Class(
      (b) => b
        ..name = '${type.displayName}Story'
        ..extend = refer('WidgetbookStory<${type.displayName}>')
        ..constructors.add(
          Constructor(
            (b) => b
              ..initializers.add(
                refer('super').call(
                  [],
                  {
                    'args': refer('args').ifNullThen(
                      refer('${type.displayName}Args()'),
                    ),
                  },
                ).code,
              )
              ..optionalParameters.addAll([
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
                    ..type = refer('${type.displayName}Args?'),
                ),
              ]),
          ),
        ),
    );
  }
}

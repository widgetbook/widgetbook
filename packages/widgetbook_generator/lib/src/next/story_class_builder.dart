import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';

class StoryClassBuilder {
  StoryClassBuilder(this.type);

  final DartType type;

  String get name => type.getDisplayString(withNullability: false);

  Class build() {
    return Class(
      (b) => b
        ..name = '${name}Story'
        ..extend = refer('WidgetbookStory<$name>')
        ..constructors.add(
          Constructor(
            (b) => b
              ..initializers.add(
                refer('super').call(
                  [],
                  {
                    'args': refer('args').ifNullThen(
                      refer('${name}Args()'),
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
                    ..type = refer('${name}Args?'),
                ),
              ]),
          ),
        ),
    );
  }
}

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
            (b) => b.optionalParameters
              ..add(
                Parameter(
                  (b) => b
                    ..name = 'name'
                    ..named = true
                    ..toSuper = true
                    ..required = true,
                ),
              )
              ..add(
                Parameter(
                  (b) => b
                    ..name = 'args'
                    ..named = true
                    ..toSuper = true
                    ..defaultTo = InvokeExpression.constOf(
                      refer('${name}Args'),
                      [],
                    ).code,
                ),
              ),
          ),
        ),
    );
  }
}

import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';

import 'extensions.dart';

class ScenarioTypedefBuilder {
  ScenarioTypedefBuilder(this.widgetType, this.argsType);

  final DartType widgetType;
  final DartType argsType;

  TypeDef build() {
    return TypeDef(
      (b) =>
          b
            ..name = '${widgetType.nonNullableName}Scenario'
            ..definition = TypeReference(
              (b) =>
                  b
                    ..symbol = 'Scenario'
                    ..types.addAll([
                      refer(widgetType.nonNullableName),
                      refer('${argsType.nonNullableName}Args'),
                    ]),
            ),
    );
  }
}

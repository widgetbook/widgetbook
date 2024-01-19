import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';

import 'extensions.dart';

class ScenarioTypedefBuilder {
  ScenarioTypedefBuilder(this.widgetType, this.argsType);

  final DartType widgetType;
  final DartType argsType;

  TypeDef build() {
    final widgetTypeRef = widgetType.getRef();
    final argsTypeRef = argsType.getRef(suffix: 'Args');
    final scenarioTypeRef = widgetType.getRef(suffix: 'Scenario');

    return TypeDef(
      (b) => b
        ..name = scenarioTypeRef.symbol
        ..types.addAll(widgetType.getTypeParams())
        ..definition = TypeReference(
          (b) => b
            ..symbol = 'Scenario'
            ..types.addAll([
              widgetTypeRef,
              argsTypeRef,
            ]),
        ),
    );
  }
}

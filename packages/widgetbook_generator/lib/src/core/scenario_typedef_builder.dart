import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';

import 'extensions.dart';

class ScenarioTypedefBuilder {
  ScenarioTypedefBuilder(this.widgetType, this.argsType);

  final DartType widgetType;
  final DartType argsType;

  Set<Reference> getTypeParams({bool withBounds = true}) {
    return {
      ...widgetType.getTypeParams(withBounds: withBounds),
      ...argsType.getTypeParams(withBounds: withBounds),
    };
  }

  TypeDef build() {
    final widgetTypeRef = widgetType.getRef();
    final scenarioTypeRef = widgetType.getRef(
      suffix: 'Scenario',
      types: getTypeParams(withBounds: false),
    );
    final argsTypeRef = argsType.getRef(
      suffix: 'Args',
      types: getTypeParams(withBounds: false),
    );

    return TypeDef(
      (b) => b
        ..name = scenarioTypeRef.symbol
        ..types.addAll(getTypeParams())
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

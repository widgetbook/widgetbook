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
    final unboundedTypeParams = getTypeParams(withBounds: false);
    final widgetTypeRef = widgetType.getRef();

    final scenarioTypeRef = widgetType.getRef(
      suffix: 'Scenario',
      types: unboundedTypeParams,
    );

    final argsTypeRef = argsType.getRef(
      suffix: 'Args',
      types: unboundedTypeParams,
    );

    return TypeDef(
      (b) =>
          b
            ..name = scenarioTypeRef.symbol
            ..types.addAll(getTypeParams())
            ..definition = TypeReference(
              (b) =>
                  b
                    ..symbol = 'Scenario'
                    ..types.addAll([
                      widgetTypeRef,
                      argsTypeRef,
                    ]),
            ),
    );
  }
}

import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';

import 'extensions.dart';

class ScenarioTypedefBuilder {
  ScenarioTypedefBuilder(this.widgetType, this.argsType);

  final DartType widgetType;
  final DartType argsType;

  TypeReference get scenarioTypeRef {
    return widgetType.getRef(
      suffix: 'Scenario',
      types: getTypeParams(withBounds: false),
    );
  }

  Set<Reference> getTypeParams({bool withBounds = true}) {
    return {
      ...widgetType.getTypeParams(withBounds: withBounds),
      ...argsType.getTypeParams(withBounds: withBounds),
    };
  }

  TypeDef buildUnderscoreType() {
    final typeRef = scenarioTypeRef;
    return TypeDef(
      (b) =>
          b
            ..name = '_Scenario'
            ..types.addAll(getTypeParams())
            ..definition = TypeReference(
              (b) =>
                  b
                    ..symbol = typeRef.symbol
                    ..types.addAll(typeRef.types),
            ),
    );
  }

  TypeDef build() {
    final unboundedTypeParams = getTypeParams(withBounds: false);
    final widgetTypeRef = widgetType.getRef();

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

import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';

import 'extensions.dart';

class ScenarioTypedefBuilder {
  ScenarioTypedefBuilder(
    this.widgetType,
    this.argsType,
    this.constructorName,
  );

  final DartType widgetType;
  final DartType argsType;

  /// The named constructor associated with the canonical meta in the file.
  /// `null` for the default (unnamed) constructor.
  final String? constructorName;

  TypeReference get scenarioTypeRef {
    return widgetType.getRef(
      suffix: '${constructorName.classPrefix}Scenario',
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
      (b) => b
        ..name = '_${constructorName.classPrefix}Scenario'
        ..types.addAll(getTypeParams())
        ..definition = TypeReference(
          (b) => b
            ..symbol = typeRef.symbol
            ..types.addAll(typeRef.types),
        ),
    );
  }

  TypeDef build() {
    final unboundedTypeParams = getTypeParams(withBounds: false);
    final widgetTypeRef = widgetType.getRef();

    final argsTypeRef = argsType.getRef(
      suffix: '${constructorName.classPrefix}Args',
      types: unboundedTypeParams,
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

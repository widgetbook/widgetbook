import 'package:code_builder/code_builder.dart';

import 'extensions.dart';
import 'variant.dart';

class ScenarioTypedefBuilder {
  ScenarioTypedefBuilder(this.variant);

  final Variant variant;

  TypeReference get scenarioTypeRef {
    return variant.widgetType.getRef(
      suffix: '${variant.prefix}Scenario',
      types: variant.getTypeParams(withBounds: false),
    );
  }

  TypeDef buildUnderscoreType() {
    final typeRef = scenarioTypeRef;
    return TypeDef(
      (b) => b
        ..name = '_${variant.prefix}Scenario'
        ..types.addAll(variant.getTypeParams())
        ..definition = TypeReference(
          (b) => b
            ..symbol = typeRef.symbol
            ..types.addAll(typeRef.types),
        ),
    );
  }

  TypeDef build() {
    final unboundedTypeParams = variant.getTypeParams(withBounds: false);
    final widgetTypeRef = variant.widgetType.getRef();

    final argsTypeRef = variant.argsType.getRef(
      suffix: variant.argsSuffix,
      types: unboundedTypeParams,
    );

    return TypeDef(
      (b) => b
        ..name = scenarioTypeRef.symbol
        ..types.addAll(variant.getTypeParams())
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

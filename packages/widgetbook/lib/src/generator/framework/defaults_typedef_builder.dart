import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';

import 'extensions.dart';

/// The `Defaults` should not have any generic parameters, as it is used across
/// Stories with different type arguments (in case of generic Components).
/// For example, for a Component `GenericWidget<T>`, the generated typedef
/// should be:
///
/// ```dart
/// typedef GenericWidgetDefaults = Defaults<GenericWidget, GenericWidgetArgs>;
/// ```
///
/// If we constraint T to be anything (even the upper bound if found), it would
/// will result in types errors.
class DefaultsTypedefBuilder {
  DefaultsTypedefBuilder(
    this.widgetType,
    this.argsType,
    this.constructorName,
  );

  final DartType widgetType;
  final DartType argsType;

  /// The named constructor associated with the canonical meta in the file.
  /// `null` for the default (unnamed) constructor.
  final String? constructorName;

  TypeReference get defaultsTypeRef {
    return widgetType.getRef(suffix: '${constructorName.classPrefix}Defaults');
  }

  TypeDef buildUnderscoreType() {
    final typeRef = defaultsTypeRef;

    return TypeDef(
      (b) => b
        ..name = '_${constructorName.classPrefix}Defaults'
        ..definition = TypeReference((b) => b..symbol = typeRef.symbol),
    );
  }

  TypeDef build() {
    return TypeDef(
      (b) => b
        ..name = defaultsTypeRef.symbol
        ..definition = TypeReference(
          (b) => b
            ..symbol = 'Defaults'
            ..types.addAll([
              refer(widgetType.nonGenericName),
              refer(
                '${argsType.nonGenericName}${constructorName.classPrefix}Args',
              ),
            ]),
        ),
    );
  }
}

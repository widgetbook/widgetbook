import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';

extension ExpressionX on Expression {
  Expression maybeProperty(
    String name, {
    required bool nullSafe,
  }) {
    return nullSafe ? this.nullSafeProperty(name) : this.property(name);
  }
}

extension FormalParameterElementX on FormalParameterElement {
  bool get requiresArg {
    return !type.isPrimitive && !type.isNullable && !hasDefaultValue;
  }
}

extension DartTypeX on DartType {
  static final typesMeta = {
    'bool?': TypeMeta('NullableBoolArg', literalNull),
    'bool': TypeMeta('BoolArg', literalFalse),
    'int?': TypeMeta('NullableIntArg', literalNull),
    'int': TypeMeta('IntArg', literalNum(0)),
    'double?': TypeMeta('NullableDoubleArg', literalNull),
    'double': TypeMeta('DoubleArg', literalNum(0.0)),
    'String?': TypeMeta('NullableStringArg', literalNull),
    'String': TypeMeta('StringArg', literalString('')),
    'Color?': TypeMeta('NullableColorArg', literalNull),
    'Color': TypeMeta(
      'ColorArg',
      InvokeExpression.constOf(
        refer('Color'),
        [literalNum(0xFF000000)],
      ),
    ),
    'Duration?': TypeMeta('NullableDurationArg', literalNull),
    'Duration': TypeMeta(
      'DurationArg',
      refer('Duration').property('zero'),
    ),
    'DateTime?': TypeMeta('NullableDateTimeArg', literalNull),
    'DateTime': TypeMeta(
      'DateTimeArg',
      refer('DateTime').property('now').call([]),
      isConst: false,
    ),
  };

  /// Gets class name without generic parameters.
  /// Can only be used on classes.
  String get nonGenericName {
    return element!.displayName;
  }

  /// Converts a type parameter bound to a [Reference], building a
  /// [TypeReference] that preserves type arguments and nullability.
  ///
  /// Without this, [nonGenericName] would strip type arguments from the
  /// bound. For example, `<D, T extends BaseItem<D>>` would lose the
  /// `<D>` and emit `T extends BaseItem` (a raw type) instead of
  /// `T extends BaseItem<D>`.
  ///
  /// Handles the following cases recursively:
  /// - Parameterized bounds: `BaseItem<D>` → `TypeReference('BaseItem', [D])`
  /// - Nullable type args: `Wrapper<D?>` → preserves the `?` on `D`
  /// - `dynamic`/`void`/function types: these have no [element], so we
  ///   fall back to [getDisplayString] (e.g. `Map<dynamic, D>`)
  Reference get _boundRef {
    final typeElement = element;
    if (typeElement == null) return refer(getDisplayString());

    final self = this;
    return TypeReference(
      (b) {
        b
          ..symbol = typeElement.displayName
          ..isNullable = isNullable;
        if (self is ParameterizedType && self.typeArguments.isNotEmpty) {
          b.types.addAll(self.typeArguments.map((t) => t._boundRef));
        }
      },
    );
  }

  Iterable<Reference> getTypeParams({
    bool withBounds = true,
  }) {
    if (this is! ParameterizedType) return [];

    final typeElement = this.element as TypeParameterizedElement;

    return typeElement.typeParameters.map(
      (typeElement) => TypeReference(
        (b) => b
          ..symbol = typeElement.name
          ..bound = withBounds && typeElement.bound != null
              ? typeElement.bound!._boundRef
              : null,
      ),
    );
  }

  TypeReference getRef({
    String? suffix,
    bool isNullable = false,
    Set<Reference>? types,
  }) {
    return TypeReference(
      (b) => b
        ..isNullable = isNullable
        ..symbol = suffix == null ? nonGenericName : '$nonGenericName$suffix'
        ..types.addAll(
          types ?? getTypeParams(withBounds: false),
        ),
    );
  }

  String get nonNullableName {
    // We get the display string with nullability then we remove the trailing
    // "?" if it exists, to avoid this issue with function and generic types:
    // 1. Function Types:
    //    - Type                : void Function(bool?)?
    //    - With nullability    : void Function(bool?)?
    //    - Without nullability : void Function(bool)
    //    - Expected            : void Function(bool?)
    // 2. Generics:
    //    - Type                : Future<bool?>?
    //    - With nullability    : Future<bool?>?
    //    - Without nullability : Future<bool>
    //    - Expected            : Future<bool?>

    final displayString = getDisplayString();

    return nullabilitySuffix != NullabilitySuffix.none
        ? displayString.substring(0, displayString.length - 1)
        : displayString;
  }

  bool get isPrimitive {
    return isEnum || typesMeta.containsKey(nonNullableName);
  }

  bool get isNullable {
    return nullabilitySuffix == NullabilitySuffix.question;
  }

  bool get isEnum {
    return element is EnumElement;
  }

  TypeMeta get meta {
    if (isEnum) {
      return isNullable
          ? TypeMeta(
              'NullableEnumArg<$nonNullableName>',
              literalNull,
            )
          : TypeMeta(
              'EnumArg<${getDisplayString()}>',
              refer(getDisplayString()).property(
                (element as EnumElement).fields.first.name!,
              ),
            );
    }

    return typesMeta[getDisplayString()]!;
  }
}

class TypeMeta {
  TypeMeta(
    this.argName,
    this.defaultValue, {
    this.isConst = true,
  });

  final String argName;
  final Expression defaultValue;

  /// Whether the [defaultValue] is a const expression
  final bool isConst;
}

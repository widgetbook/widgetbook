import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';

import 'extensions.dart';

/// A single story variant of a component, derived from a top-level `Meta`
/// variable. Each variant targets one constructor of the component's widget,
/// provided as a constructor tear-off: `Meta(MyButton.new)` or
/// `Meta(MyButton.icon)`.
class Variant {
  Variant({
    required this.metaVariable,
    required this.constructor,
    this.argsConstructor,
  });

  final TopLevelVariableElement metaVariable;
  final ConstructorElement constructor;

  /// The constructor of the custom args class provided via `Meta.argsType`,
  /// or null if args are derived from the widget [constructor].
  final ConstructorElement? argsConstructor;

  /// Resolves [variable] into a [Variant] if it is declared with type `Meta`.
  /// Returns null for all other variables.
  static Variant? fromVariable(TopLevelVariableElement variable) {
    final type = variable.type;
    if (type is! InterfaceType || type.element.name != 'Meta') return null;

    final constant = variable.computeConstantValue();
    final constructor = getFieldOnChain(
      constant,
      'constructor',
    )?.toFunctionValue();

    if (constructor == null) {
      throw InvalidGenerationSourceError(
        '`${variable.displayName}` must be declared as `const` with a '
        'constructor tear-off, e.g. `const meta = Meta(MyWidget.new)`.',
        element: variable,
      );
    }

    if (constructor is! ConstructorElement) {
      throw InvalidGenerationSourceError(
        '`${variable.displayName}` must reference a constructor tear-off '
        '(e.g. `MyWidget.new` or `MyWidget.named`), '
        'but `${constructor.displayName}` is not a constructor.',
        element: variable,
      );
    }

    final argsType = getFieldOnChain(constant, 'argsType');
    final argsConstructor = argsType?.toFunctionValue();

    if (argsType != null &&
        !argsType.isNull &&
        argsConstructor is! ConstructorElement) {
      throw InvalidGenerationSourceError(
        '`${variable.displayName}` must provide `argsType` as a constructor '
        'tear-off of the args class, e.g. '
        '`Meta(MyWidget.new, argsType: MyArgs.new)`.',
        element: variable,
      );
    }

    return Variant(
      metaVariable: variable,
      constructor: constructor,
      argsConstructor: argsConstructor as ConstructorElement?,
    );
  }

  /// Gets the field [name] of a constant [object], also looking through the
  /// fields inherited from its superclasses, which [DartObject.getField]
  /// stores under a synthetic `(super)` field.
  static DartObject? getFieldOnChain(DartObject? object, String name) {
    var current = object;

    while (current != null) {
      final field = current.getField(name);
      if (field != null) return field;
      current = current.getField('(super)');
    }

    return null;
  }

  InterfaceType get widgetType => constructor.enclosingElement.thisType;

  /// The type that provides the args model. The custom args class when
  /// [argsConstructor] is provided, otherwise the widget itself.
  InterfaceType get argsType =>
      argsConstructor?.enclosingElement.thisType ?? widgetType;

  /// Whether the args model is a custom class (via `Meta.argsType`) instead
  /// of the widget itself.
  bool get isCustomArgs => argsConstructor != null;

  /// The name of [constructor], or null for the unnamed constructor.
  String? get constructorName {
    final name = constructor.name;
    return name == null || name.isEmpty || name == 'new' ? null : name;
  }

  /// The PascalCase name of [constructor] that prefixes the generated type
  /// names. Empty for the unnamed constructor, so that its generated names
  /// are unprefixed, e.g. `_Story` vs `_IconStory`.
  String get prefix {
    final name = constructorName;
    if (name == null) return '';

    final public = name.replaceFirst(RegExp(r'^_+'), '');

    if (public.isEmpty) {
      throw InvalidGenerationSourceError(
        'Cannot generate a type prefix for constructor `$name`.',
        element: metaVariable,
      );
    }

    return public[0].toUpperCase() + public.substring(1);
  }

  /// Suffix appended to [argsType]'s class name for the generated args class.
  /// Custom args classes are not prefixed, as they are unique per variant.
  String get argsSuffix => isCustomArgs ? 'Args' : '${prefix}Args';

  /// The name of the generated args class.
  String get argsClassName => '${argsType.nonGenericName}$argsSuffix';

  /// The formal parameters that make up the generated args class: the
  /// parameters of the [argsConstructor] for custom args, or of the widget
  /// [constructor] otherwise.
  Iterable<FormalParameterElement> get params {
    return (argsConstructor ?? constructor).formalParameters;
  }

  Set<Reference> getTypeParams({bool withBounds = true}) {
    return {
      ...widgetType.getTypeParams(withBounds: withBounds),
      ...argsType.getTypeParams(withBounds: withBounds),
    };
  }
}

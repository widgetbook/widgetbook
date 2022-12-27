// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'changed_use_case.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChangedUseCase _$ChangedUseCaseFromJson(Map<String, dynamic> json) {
  return _ChangedUseCase.fromJson(json);
}

/// @nodoc
mixin _$ChangedUseCase {
  String get name => throw _privateConstructorUsedError;
  String get componentName => throw _privateConstructorUsedError;
  String get componentDefinitionPath => throw _privateConstructorUsedError;
  Modification get modification => throw _privateConstructorUsedError;
  String? get designLink => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChangedUseCaseCopyWith<ChangedUseCase> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChangedUseCaseCopyWith<$Res> {
  factory $ChangedUseCaseCopyWith(
          ChangedUseCase value, $Res Function(ChangedUseCase) then) =
      _$ChangedUseCaseCopyWithImpl<$Res>;
  $Res call(
      {String name,
      String componentName,
      String componentDefinitionPath,
      Modification modification,
      String? designLink});
}

/// @nodoc
class _$ChangedUseCaseCopyWithImpl<$Res>
    implements $ChangedUseCaseCopyWith<$Res> {
  _$ChangedUseCaseCopyWithImpl(this._value, this._then);

  final ChangedUseCase _value;
  // ignore: unused_field
  final $Res Function(ChangedUseCase) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? componentName = freezed,
    Object? componentDefinitionPath = freezed,
    Object? modification = freezed,
    Object? designLink = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      componentName: componentName == freezed
          ? _value.componentName
          : componentName // ignore: cast_nullable_to_non_nullable
              as String,
      componentDefinitionPath: componentDefinitionPath == freezed
          ? _value.componentDefinitionPath
          : componentDefinitionPath // ignore: cast_nullable_to_non_nullable
              as String,
      modification: modification == freezed
          ? _value.modification
          : modification // ignore: cast_nullable_to_non_nullable
              as Modification,
      designLink: designLink == freezed
          ? _value.designLink
          : designLink // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_ChangedUseCaseCopyWith<$Res>
    implements $ChangedUseCaseCopyWith<$Res> {
  factory _$$_ChangedUseCaseCopyWith(
          _$_ChangedUseCase value, $Res Function(_$_ChangedUseCase) then) =
      __$$_ChangedUseCaseCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      String componentName,
      String componentDefinitionPath,
      Modification modification,
      String? designLink});
}

/// @nodoc
class __$$_ChangedUseCaseCopyWithImpl<$Res>
    extends _$ChangedUseCaseCopyWithImpl<$Res>
    implements _$$_ChangedUseCaseCopyWith<$Res> {
  __$$_ChangedUseCaseCopyWithImpl(
      _$_ChangedUseCase _value, $Res Function(_$_ChangedUseCase) _then)
      : super(_value, (v) => _then(v as _$_ChangedUseCase));

  @override
  _$_ChangedUseCase get _value => super._value as _$_ChangedUseCase;

  @override
  $Res call({
    Object? name = freezed,
    Object? componentName = freezed,
    Object? componentDefinitionPath = freezed,
    Object? modification = freezed,
    Object? designLink = freezed,
  }) {
    return _then(_$_ChangedUseCase(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      componentName: componentName == freezed
          ? _value.componentName
          : componentName // ignore: cast_nullable_to_non_nullable
              as String,
      componentDefinitionPath: componentDefinitionPath == freezed
          ? _value.componentDefinitionPath
          : componentDefinitionPath // ignore: cast_nullable_to_non_nullable
              as String,
      modification: modification == freezed
          ? _value.modification
          : modification // ignore: cast_nullable_to_non_nullable
              as Modification,
      designLink: designLink == freezed
          ? _value.designLink
          : designLink // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ChangedUseCase implements _ChangedUseCase {
  _$_ChangedUseCase(
      {required this.name,
      required this.componentName,
      required this.componentDefinitionPath,
      required this.modification,
      required this.designLink});

  factory _$_ChangedUseCase.fromJson(Map<String, dynamic> json) =>
      _$$_ChangedUseCaseFromJson(json);

  @override
  final String name;
  @override
  final String componentName;
  @override
  final String componentDefinitionPath;
  @override
  final Modification modification;
  @override
  final String? designLink;

  @override
  String toString() {
    return 'ChangedUseCase(name: $name, componentName: $componentName, componentDefinitionPath: $componentDefinitionPath, modification: $modification, designLink: $designLink)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChangedUseCase &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.componentName, componentName) &&
            const DeepCollectionEquality().equals(
                other.componentDefinitionPath, componentDefinitionPath) &&
            const DeepCollectionEquality()
                .equals(other.modification, modification) &&
            const DeepCollectionEquality()
                .equals(other.designLink, designLink));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(componentName),
      const DeepCollectionEquality().hash(componentDefinitionPath),
      const DeepCollectionEquality().hash(modification),
      const DeepCollectionEquality().hash(designLink));

  @JsonKey(ignore: true)
  @override
  _$$_ChangedUseCaseCopyWith<_$_ChangedUseCase> get copyWith =>
      __$$_ChangedUseCaseCopyWithImpl<_$_ChangedUseCase>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChangedUseCaseToJson(this);
  }
}

abstract class _ChangedUseCase implements ChangedUseCase {
  factory _ChangedUseCase(
      {required final String name,
      required final String componentName,
      required final String componentDefinitionPath,
      required final Modification modification,
      required final String? designLink}) = _$_ChangedUseCase;

  factory _ChangedUseCase.fromJson(Map<String, dynamic> json) =
      _$_ChangedUseCase.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get componentName => throw _privateConstructorUsedError;
  @override
  String get componentDefinitionPath => throw _privateConstructorUsedError;
  @override
  Modification get modification => throw _privateConstructorUsedError;
  @override
  String? get designLink => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ChangedUseCaseCopyWith<_$_ChangedUseCase> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'widgetbook_locale_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WidgetbookLocaleData _$WidgetbookLocaleDataFromJson(Map<String, dynamic> json) {
  return _WidgetbookLocaleData.fromJson(json);
}

/// @nodoc
mixin _$WidgetbookLocaleData {
  String get name => throw _privateConstructorUsedError;
  String get importStatement => throw _privateConstructorUsedError;
  List<String> get dependencies => throw _privateConstructorUsedError;
  List<String> get locales => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WidgetbookLocaleDataCopyWith<WidgetbookLocaleData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WidgetbookLocaleDataCopyWith<$Res> {
  factory $WidgetbookLocaleDataCopyWith(WidgetbookLocaleData value,
          $Res Function(WidgetbookLocaleData) then) =
      _$WidgetbookLocaleDataCopyWithImpl<$Res>;
  $Res call(
      {String name,
      String importStatement,
      List<String> dependencies,
      List<String> locales});
}

/// @nodoc
class _$WidgetbookLocaleDataCopyWithImpl<$Res>
    implements $WidgetbookLocaleDataCopyWith<$Res> {
  _$WidgetbookLocaleDataCopyWithImpl(this._value, this._then);

  final WidgetbookLocaleData _value;
  // ignore: unused_field
  final $Res Function(WidgetbookLocaleData) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? importStatement = freezed,
    Object? dependencies = freezed,
    Object? locales = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      importStatement: importStatement == freezed
          ? _value.importStatement
          : importStatement // ignore: cast_nullable_to_non_nullable
              as String,
      dependencies: dependencies == freezed
          ? _value.dependencies
          : dependencies // ignore: cast_nullable_to_non_nullable
              as List<String>,
      locales: locales == freezed
          ? _value.locales
          : locales // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
abstract class _$$_WidgetbookLocaleDataCopyWith<$Res>
    implements $WidgetbookLocaleDataCopyWith<$Res> {
  factory _$$_WidgetbookLocaleDataCopyWith(_$_WidgetbookLocaleData value,
          $Res Function(_$_WidgetbookLocaleData) then) =
      __$$_WidgetbookLocaleDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      String importStatement,
      List<String> dependencies,
      List<String> locales});
}

/// @nodoc
class __$$_WidgetbookLocaleDataCopyWithImpl<$Res>
    extends _$WidgetbookLocaleDataCopyWithImpl<$Res>
    implements _$$_WidgetbookLocaleDataCopyWith<$Res> {
  __$$_WidgetbookLocaleDataCopyWithImpl(_$_WidgetbookLocaleData _value,
      $Res Function(_$_WidgetbookLocaleData) _then)
      : super(_value, (v) => _then(v as _$_WidgetbookLocaleData));

  @override
  _$_WidgetbookLocaleData get _value => super._value as _$_WidgetbookLocaleData;

  @override
  $Res call({
    Object? name = freezed,
    Object? importStatement = freezed,
    Object? dependencies = freezed,
    Object? locales = freezed,
  }) {
    return _then(_$_WidgetbookLocaleData(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      importStatement: importStatement == freezed
          ? _value.importStatement
          : importStatement // ignore: cast_nullable_to_non_nullable
              as String,
      dependencies: dependencies == freezed
          ? _value._dependencies
          : dependencies // ignore: cast_nullable_to_non_nullable
              as List<String>,
      locales: locales == freezed
          ? _value._locales
          : locales // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WidgetbookLocaleData implements _WidgetbookLocaleData {
  _$_WidgetbookLocaleData(
      {required this.name,
      required this.importStatement,
      required final List<String> dependencies,
      required final List<String> locales})
      : _dependencies = dependencies,
        _locales = locales;

  factory _$_WidgetbookLocaleData.fromJson(Map<String, dynamic> json) =>
      _$$_WidgetbookLocaleDataFromJson(json);

  @override
  final String name;
  @override
  final String importStatement;
  final List<String> _dependencies;
  @override
  List<String> get dependencies {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dependencies);
  }

  final List<String> _locales;
  @override
  List<String> get locales {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_locales);
  }

  @override
  String toString() {
    return 'WidgetbookLocaleData(name: $name, importStatement: $importStatement, dependencies: $dependencies, locales: $locales)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WidgetbookLocaleData &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.importStatement, importStatement) &&
            const DeepCollectionEquality()
                .equals(other._dependencies, _dependencies) &&
            const DeepCollectionEquality().equals(other._locales, _locales));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(importStatement),
      const DeepCollectionEquality().hash(_dependencies),
      const DeepCollectionEquality().hash(_locales));

  @JsonKey(ignore: true)
  @override
  _$$_WidgetbookLocaleDataCopyWith<_$_WidgetbookLocaleData> get copyWith =>
      __$$_WidgetbookLocaleDataCopyWithImpl<_$_WidgetbookLocaleData>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WidgetbookLocaleDataToJson(this);
  }
}

abstract class _WidgetbookLocaleData implements WidgetbookLocaleData {
  factory _WidgetbookLocaleData(
      {required final String name,
      required final String importStatement,
      required final List<String> dependencies,
      required final List<String> locales}) = _$_WidgetbookLocaleData;

  factory _WidgetbookLocaleData.fromJson(Map<String, dynamic> json) =
      _$_WidgetbookLocaleData.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get importStatement => throw _privateConstructorUsedError;
  @override
  List<String> get dependencies => throw _privateConstructorUsedError;
  @override
  List<String> get locales => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_WidgetbookLocaleDataCopyWith<_$_WidgetbookLocaleData> get copyWith =>
      throw _privateConstructorUsedError;
}

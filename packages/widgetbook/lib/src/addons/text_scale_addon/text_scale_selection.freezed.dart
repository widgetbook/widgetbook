// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'text_scale_selection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TextScaleSelection {
  Set<double> get activeTextScales => throw _privateConstructorUsedError;
  List<double> get textScales => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TextScaleSelectionCopyWith<TextScaleSelection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TextScaleSelectionCopyWith<$Res> {
  factory $TextScaleSelectionCopyWith(
          TextScaleSelection value, $Res Function(TextScaleSelection) then) =
      _$TextScaleSelectionCopyWithImpl<$Res>;
  $Res call({Set<double> activeTextScales, List<double> textScales});
}

/// @nodoc
class _$TextScaleSelectionCopyWithImpl<$Res>
    implements $TextScaleSelectionCopyWith<$Res> {
  _$TextScaleSelectionCopyWithImpl(this._value, this._then);

  final TextScaleSelection _value;
  // ignore: unused_field
  final $Res Function(TextScaleSelection) _then;

  @override
  $Res call({
    Object? activeTextScales = freezed,
    Object? textScales = freezed,
  }) {
    return _then(_value.copyWith(
      activeTextScales: activeTextScales == freezed
          ? _value.activeTextScales
          : activeTextScales // ignore: cast_nullable_to_non_nullable
              as Set<double>,
      textScales: textScales == freezed
          ? _value.textScales
          : textScales // ignore: cast_nullable_to_non_nullable
              as List<double>,
    ));
  }
}

/// @nodoc
abstract class _$$_TextScaleSelectionCopyWith<$Res>
    implements $TextScaleSelectionCopyWith<$Res> {
  factory _$$_TextScaleSelectionCopyWith(_$_TextScaleSelection value,
          $Res Function(_$_TextScaleSelection) then) =
      __$$_TextScaleSelectionCopyWithImpl<$Res>;
  @override
  $Res call({Set<double> activeTextScales, List<double> textScales});
}

/// @nodoc
class __$$_TextScaleSelectionCopyWithImpl<$Res>
    extends _$TextScaleSelectionCopyWithImpl<$Res>
    implements _$$_TextScaleSelectionCopyWith<$Res> {
  __$$_TextScaleSelectionCopyWithImpl(
      _$_TextScaleSelection _value, $Res Function(_$_TextScaleSelection) _then)
      : super(_value, (v) => _then(v as _$_TextScaleSelection));

  @override
  _$_TextScaleSelection get _value => super._value as _$_TextScaleSelection;

  @override
  $Res call({
    Object? activeTextScales = freezed,
    Object? textScales = freezed,
  }) {
    return _then(_$_TextScaleSelection(
      activeTextScales: activeTextScales == freezed
          ? _value._activeTextScales
          : activeTextScales // ignore: cast_nullable_to_non_nullable
              as Set<double>,
      textScales: textScales == freezed
          ? _value._textScales
          : textScales // ignore: cast_nullable_to_non_nullable
              as List<double>,
    ));
  }
}

/// @nodoc

class _$_TextScaleSelection implements _TextScaleSelection {
  _$_TextScaleSelection(
      {required final Set<double> activeTextScales,
      required final List<double> textScales})
      : _activeTextScales = activeTextScales,
        _textScales = textScales;

  final Set<double> _activeTextScales;
  @override
  Set<double> get activeTextScales {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_activeTextScales);
  }

  final List<double> _textScales;
  @override
  List<double> get textScales {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_textScales);
  }

  @override
  String toString() {
    return 'TextScaleSelection(activeTextScales: $activeTextScales, textScales: $textScales)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TextScaleSelection &&
            const DeepCollectionEquality()
                .equals(other._activeTextScales, _activeTextScales) &&
            const DeepCollectionEquality()
                .equals(other._textScales, _textScales));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_activeTextScales),
      const DeepCollectionEquality().hash(_textScales));

  @JsonKey(ignore: true)
  @override
  _$$_TextScaleSelectionCopyWith<_$_TextScaleSelection> get copyWith =>
      __$$_TextScaleSelectionCopyWithImpl<_$_TextScaleSelection>(
          this, _$identity);
}

abstract class _TextScaleSelection implements TextScaleSelection {
  factory _TextScaleSelection(
      {required final Set<double> activeTextScales,
      required final List<double> textScales}) = _$_TextScaleSelection;

  @override
  Set<double> get activeTextScales => throw _privateConstructorUsedError;
  @override
  List<double> get textScales => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_TextScaleSelectionCopyWith<_$_TextScaleSelection> get copyWith =>
      throw _privateConstructorUsedError;
}

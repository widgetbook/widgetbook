// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'frame_setting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$FrameSetting {
  List<Frame> get frames => throw _privateConstructorUsedError;
  Frame get activeFrame => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FrameSettingCopyWith<FrameSetting> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FrameSettingCopyWith<$Res> {
  factory $FrameSettingCopyWith(
          FrameSetting value, $Res Function(FrameSetting) then) =
      _$FrameSettingCopyWithImpl<$Res, FrameSetting>;
  @useResult
  $Res call({List<Frame> frames, Frame activeFrame});
}

/// @nodoc
class _$FrameSettingCopyWithImpl<$Res, $Val extends FrameSetting>
    implements $FrameSettingCopyWith<$Res> {
  _$FrameSettingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? frames = null,
    Object? activeFrame = null,
  }) {
    return _then(_value.copyWith(
      frames: null == frames
          ? _value.frames
          : frames // ignore: cast_nullable_to_non_nullable
              as List<Frame>,
      activeFrame: null == activeFrame
          ? _value.activeFrame
          : activeFrame // ignore: cast_nullable_to_non_nullable
              as Frame,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FrameSettingCopyWith<$Res>
    implements $FrameSettingCopyWith<$Res> {
  factory _$$_FrameSettingCopyWith(
          _$_FrameSetting value, $Res Function(_$_FrameSetting) then) =
      __$$_FrameSettingCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Frame> frames, Frame activeFrame});
}

/// @nodoc
class __$$_FrameSettingCopyWithImpl<$Res>
    extends _$FrameSettingCopyWithImpl<$Res, _$_FrameSetting>
    implements _$$_FrameSettingCopyWith<$Res> {
  __$$_FrameSettingCopyWithImpl(
      _$_FrameSetting _value, $Res Function(_$_FrameSetting) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? frames = null,
    Object? activeFrame = null,
  }) {
    return _then(_$_FrameSetting(
      frames: null == frames
          ? _value._frames
          : frames // ignore: cast_nullable_to_non_nullable
              as List<Frame>,
      activeFrame: null == activeFrame
          ? _value.activeFrame
          : activeFrame // ignore: cast_nullable_to_non_nullable
              as Frame,
    ));
  }
}

/// @nodoc

class _$_FrameSetting implements _FrameSetting {
  _$_FrameSetting(
      {required final List<Frame> frames, required this.activeFrame})
      : assert(frames.isNotEmpty, 'frames cannot be empty'),
        _frames = frames;

  final List<Frame> _frames;
  @override
  List<Frame> get frames {
    if (_frames is EqualUnmodifiableListView) return _frames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_frames);
  }

  @override
  final Frame activeFrame;

  @override
  String toString() {
    return 'FrameSetting(frames: $frames, activeFrame: $activeFrame)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FrameSetting &&
            const DeepCollectionEquality().equals(other._frames, _frames) &&
            (identical(other.activeFrame, activeFrame) ||
                other.activeFrame == activeFrame));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_frames), activeFrame);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FrameSettingCopyWith<_$_FrameSetting> get copyWith =>
      __$$_FrameSettingCopyWithImpl<_$_FrameSetting>(this, _$identity);
}

abstract class _FrameSetting implements FrameSetting {
  factory _FrameSetting(
      {required final List<Frame> frames,
      required final Frame activeFrame}) = _$_FrameSetting;

  @override
  List<Frame> get frames;
  @override
  Frame get activeFrame;
  @override
  @JsonKey(ignore: true)
  _$$_FrameSettingCopyWith<_$_FrameSetting> get copyWith =>
      throw _privateConstructorUsedError;
}

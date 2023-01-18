// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'navigation_tree_node_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$NavigationTreeNodeData {
  String get path => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  NavigationNodeType get type => throw _privateConstructorUsedError;
  bool get isInitiallyExpanded => throw _privateConstructorUsedError;
  List<NavigationTreeNodeData> get children =>
      throw _privateConstructorUsedError;
  dynamic get data => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NavigationTreeNodeDataCopyWith<NavigationTreeNodeData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NavigationTreeNodeDataCopyWith<$Res> {
  factory $NavigationTreeNodeDataCopyWith(NavigationTreeNodeData value,
          $Res Function(NavigationTreeNodeData) then) =
      _$NavigationTreeNodeDataCopyWithImpl<$Res, NavigationTreeNodeData>;
  @useResult
  $Res call(
      {String path,
      String name,
      NavigationNodeType type,
      bool isInitiallyExpanded,
      List<NavigationTreeNodeData> children,
      dynamic data});
}

/// @nodoc
class _$NavigationTreeNodeDataCopyWithImpl<$Res,
        $Val extends NavigationTreeNodeData>
    implements $NavigationTreeNodeDataCopyWith<$Res> {
  _$NavigationTreeNodeDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
    Object? name = null,
    Object? type = null,
    Object? isInitiallyExpanded = null,
    Object? children = null,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NavigationNodeType,
      isInitiallyExpanded: null == isInitiallyExpanded
          ? _value.isInitiallyExpanded
          : isInitiallyExpanded // ignore: cast_nullable_to_non_nullable
              as bool,
      children: null == children
          ? _value.children
          : children // ignore: cast_nullable_to_non_nullable
              as List<NavigationTreeNodeData>,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NavigationTreeNodeDataCopyWith<$Res>
    implements $NavigationTreeNodeDataCopyWith<$Res> {
  factory _$$_NavigationTreeNodeDataCopyWith(_$_NavigationTreeNodeData value,
          $Res Function(_$_NavigationTreeNodeData) then) =
      __$$_NavigationTreeNodeDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String path,
      String name,
      NavigationNodeType type,
      bool isInitiallyExpanded,
      List<NavigationTreeNodeData> children,
      dynamic data});
}

/// @nodoc
class __$$_NavigationTreeNodeDataCopyWithImpl<$Res>
    extends _$NavigationTreeNodeDataCopyWithImpl<$Res,
        _$_NavigationTreeNodeData>
    implements _$$_NavigationTreeNodeDataCopyWith<$Res> {
  __$$_NavigationTreeNodeDataCopyWithImpl(_$_NavigationTreeNodeData _value,
      $Res Function(_$_NavigationTreeNodeData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
    Object? name = null,
    Object? type = null,
    Object? isInitiallyExpanded = null,
    Object? children = null,
    Object? data = freezed,
  }) {
    return _then(_$_NavigationTreeNodeData(
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NavigationNodeType,
      isInitiallyExpanded: null == isInitiallyExpanded
          ? _value.isInitiallyExpanded
          : isInitiallyExpanded // ignore: cast_nullable_to_non_nullable
              as bool,
      children: null == children
          ? _value._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<NavigationTreeNodeData>,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$_NavigationTreeNodeData extends _NavigationTreeNodeData {
  const _$_NavigationTreeNodeData(
      {required this.path,
      required this.name,
      required this.type,
      this.isInitiallyExpanded = true,
      final List<NavigationTreeNodeData> children = const [],
      this.data})
      : _children = children,
        super._();

  @override
  final String path;
  @override
  final String name;
  @override
  final NavigationNodeType type;
  @override
  @JsonKey()
  final bool isInitiallyExpanded;
  final List<NavigationTreeNodeData> _children;
  @override
  @JsonKey()
  List<NavigationTreeNodeData> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

  @override
  final dynamic data;

  @override
  String toString() {
    return 'NavigationTreeNodeData(path: $path, name: $name, type: $type, isInitiallyExpanded: $isInitiallyExpanded, children: $children, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NavigationTreeNodeData &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.isInitiallyExpanded, isInitiallyExpanded) ||
                other.isInitiallyExpanded == isInitiallyExpanded) &&
            const DeepCollectionEquality().equals(other._children, _children) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      path,
      name,
      type,
      isInitiallyExpanded,
      const DeepCollectionEquality().hash(_children),
      const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NavigationTreeNodeDataCopyWith<_$_NavigationTreeNodeData> get copyWith =>
      __$$_NavigationTreeNodeDataCopyWithImpl<_$_NavigationTreeNodeData>(
          this, _$identity);
}

abstract class _NavigationTreeNodeData extends NavigationTreeNodeData {
  const factory _NavigationTreeNodeData(
      {required final String path,
      required final String name,
      required final NavigationNodeType type,
      final bool isInitiallyExpanded,
      final List<NavigationTreeNodeData> children,
      final dynamic data}) = _$_NavigationTreeNodeData;
  const _NavigationTreeNodeData._() : super._();

  @override
  String get path;
  @override
  String get name;
  @override
  NavigationNodeType get type;
  @override
  bool get isInitiallyExpanded;
  @override
  List<NavigationTreeNodeData> get children;
  @override
  dynamic get data;
  @override
  @JsonKey(ignore: true)
  _$$_NavigationTreeNodeDataCopyWith<_$_NavigationTreeNodeData> get copyWith =>
      throw _privateConstructorUsedError;
}

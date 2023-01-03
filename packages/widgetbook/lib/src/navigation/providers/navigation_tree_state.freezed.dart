// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'navigation_tree_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$NavigationTreeState {
  List<MultiChildNavigationNodeData> get nodes =>
      throw _privateConstructorUsedError;
  List<MultiChildNavigationNodeData> get filteredNodes =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NavigationTreeStateCopyWith<NavigationTreeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NavigationTreeStateCopyWith<$Res> {
  factory $NavigationTreeStateCopyWith(
          NavigationTreeState value, $Res Function(NavigationTreeState) then) =
      _$NavigationTreeStateCopyWithImpl<$Res>;
  $Res call(
      {List<MultiChildNavigationNodeData> nodes,
      List<MultiChildNavigationNodeData> filteredNodes});
}

/// @nodoc
class _$NavigationTreeStateCopyWithImpl<$Res>
    implements $NavigationTreeStateCopyWith<$Res> {
  _$NavigationTreeStateCopyWithImpl(this._value, this._then);

  final NavigationTreeState _value;
  // ignore: unused_field
  final $Res Function(NavigationTreeState) _then;

  @override
  $Res call({
    Object? nodes = freezed,
    Object? filteredNodes = freezed,
  }) {
    return _then(_value.copyWith(
      nodes: nodes == freezed
          ? _value.nodes
          : nodes // ignore: cast_nullable_to_non_nullable
              as List<MultiChildNavigationNodeData>,
      filteredNodes: filteredNodes == freezed
          ? _value.filteredNodes
          : filteredNodes // ignore: cast_nullable_to_non_nullable
              as List<MultiChildNavigationNodeData>,
    ));
  }
}

/// @nodoc
abstract class _$$_NavigationTreeStateCopyWith<$Res>
    implements $NavigationTreeStateCopyWith<$Res> {
  factory _$$_NavigationTreeStateCopyWith(_$_NavigationTreeState value,
          $Res Function(_$_NavigationTreeState) then) =
      __$$_NavigationTreeStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<MultiChildNavigationNodeData> nodes,
      List<MultiChildNavigationNodeData> filteredNodes});
}

/// @nodoc
class __$$_NavigationTreeStateCopyWithImpl<$Res>
    extends _$NavigationTreeStateCopyWithImpl<$Res>
    implements _$$_NavigationTreeStateCopyWith<$Res> {
  __$$_NavigationTreeStateCopyWithImpl(_$_NavigationTreeState _value,
      $Res Function(_$_NavigationTreeState) _then)
      : super(_value, (v) => _then(v as _$_NavigationTreeState));

  @override
  _$_NavigationTreeState get _value => super._value as _$_NavigationTreeState;

  @override
  $Res call({
    Object? nodes = freezed,
    Object? filteredNodes = freezed,
  }) {
    return _then(_$_NavigationTreeState(
      nodes: nodes == freezed
          ? _value._nodes
          : nodes // ignore: cast_nullable_to_non_nullable
              as List<MultiChildNavigationNodeData>,
      filteredNodes: filteredNodes == freezed
          ? _value._filteredNodes
          : filteredNodes // ignore: cast_nullable_to_non_nullable
              as List<MultiChildNavigationNodeData>,
    ));
  }
}

/// @nodoc

class _$_NavigationTreeState implements _NavigationTreeState {
  const _$_NavigationTreeState(
      {final List<MultiChildNavigationNodeData> nodes =
          const <MultiChildNavigationNodeData>[],
      final List<MultiChildNavigationNodeData> filteredNodes =
          const <MultiChildNavigationNodeData>[]})
      : _nodes = nodes,
        _filteredNodes = filteredNodes;

  final List<MultiChildNavigationNodeData> _nodes;
  @override
  @JsonKey()
  List<MultiChildNavigationNodeData> get nodes {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_nodes);
  }

  final List<MultiChildNavigationNodeData> _filteredNodes;
  @override
  @JsonKey()
  List<MultiChildNavigationNodeData> get filteredNodes {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filteredNodes);
  }

  @override
  String toString() {
    return 'NavigationTreeState(nodes: $nodes, filteredNodes: $filteredNodes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NavigationTreeState &&
            const DeepCollectionEquality().equals(other._nodes, _nodes) &&
            const DeepCollectionEquality()
                .equals(other._filteredNodes, _filteredNodes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_nodes),
      const DeepCollectionEquality().hash(_filteredNodes));

  @JsonKey(ignore: true)
  @override
  _$$_NavigationTreeStateCopyWith<_$_NavigationTreeState> get copyWith =>
      __$$_NavigationTreeStateCopyWithImpl<_$_NavigationTreeState>(
          this, _$identity);
}

abstract class _NavigationTreeState implements NavigationTreeState {
  const factory _NavigationTreeState(
          {final List<MultiChildNavigationNodeData> nodes,
          final List<MultiChildNavigationNodeData> filteredNodes}) =
      _$_NavigationTreeState;

  @override
  List<MultiChildNavigationNodeData> get nodes;
  @override
  List<MultiChildNavigationNodeData> get filteredNodes;
  @override
  @JsonKey(ignore: true)
  _$$_NavigationTreeStateCopyWith<_$_NavigationTreeState> get copyWith =>
      throw _privateConstructorUsedError;
}

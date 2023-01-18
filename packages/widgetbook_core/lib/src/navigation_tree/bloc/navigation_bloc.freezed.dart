// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'navigation_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$NavigationEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<MultiChildNavigationNodeData> directories)
        load,
    required TResult Function(NavigationTreeNodeData node) selectNode,
    required TResult Function(String path) selectNodeByPath,
    required TResult Function(String searchQuery) filterNodes,
    required TResult Function() resetNodesFilters,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<MultiChildNavigationNodeData> directories)? load,
    TResult? Function(NavigationTreeNodeData node)? selectNode,
    TResult? Function(String path)? selectNodeByPath,
    TResult? Function(String searchQuery)? filterNodes,
    TResult? Function()? resetNodesFilters,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<MultiChildNavigationNodeData> directories)? load,
    TResult Function(NavigationTreeNodeData node)? selectNode,
    TResult Function(String path)? selectNodeByPath,
    TResult Function(String searchQuery)? filterNodes,
    TResult Function()? resetNodesFilters,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadNavigationTree value) load,
    required TResult Function(SelectNavigationNode value) selectNode,
    required TResult Function(SelectNavigationNodeByPath value)
        selectNodeByPath,
    required TResult Function(FilterNavigationNodes value) filterNodes,
    required TResult Function(ResetNodesFilter value) resetNodesFilters,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadNavigationTree value)? load,
    TResult? Function(SelectNavigationNode value)? selectNode,
    TResult? Function(SelectNavigationNodeByPath value)? selectNodeByPath,
    TResult? Function(FilterNavigationNodes value)? filterNodes,
    TResult? Function(ResetNodesFilter value)? resetNodesFilters,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadNavigationTree value)? load,
    TResult Function(SelectNavigationNode value)? selectNode,
    TResult Function(SelectNavigationNodeByPath value)? selectNodeByPath,
    TResult Function(FilterNavigationNodes value)? filterNodes,
    TResult Function(ResetNodesFilter value)? resetNodesFilters,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NavigationEventCopyWith<$Res> {
  factory $NavigationEventCopyWith(
          NavigationEvent value, $Res Function(NavigationEvent) then) =
      _$NavigationEventCopyWithImpl<$Res, NavigationEvent>;
}

/// @nodoc
class _$NavigationEventCopyWithImpl<$Res, $Val extends NavigationEvent>
    implements $NavigationEventCopyWith<$Res> {
  _$NavigationEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$LoadNavigationTreeCopyWith<$Res> {
  factory _$$LoadNavigationTreeCopyWith(_$LoadNavigationTree value,
          $Res Function(_$LoadNavigationTree) then) =
      __$$LoadNavigationTreeCopyWithImpl<$Res>;
  @useResult
  $Res call({List<MultiChildNavigationNodeData> directories});
}

/// @nodoc
class __$$LoadNavigationTreeCopyWithImpl<$Res>
    extends _$NavigationEventCopyWithImpl<$Res, _$LoadNavigationTree>
    implements _$$LoadNavigationTreeCopyWith<$Res> {
  __$$LoadNavigationTreeCopyWithImpl(
      _$LoadNavigationTree _value, $Res Function(_$LoadNavigationTree) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? directories = null,
  }) {
    return _then(_$LoadNavigationTree(
      directories: null == directories
          ? _value._directories
          : directories // ignore: cast_nullable_to_non_nullable
              as List<MultiChildNavigationNodeData>,
    ));
  }
}

/// @nodoc

class _$LoadNavigationTree implements LoadNavigationTree {
  const _$LoadNavigationTree(
      {required final List<MultiChildNavigationNodeData> directories})
      : _directories = directories;

  final List<MultiChildNavigationNodeData> _directories;
  @override
  List<MultiChildNavigationNodeData> get directories {
    if (_directories is EqualUnmodifiableListView) return _directories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_directories);
  }

  @override
  String toString() {
    return 'NavigationEvent.load(directories: $directories)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadNavigationTree &&
            const DeepCollectionEquality()
                .equals(other._directories, _directories));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_directories));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadNavigationTreeCopyWith<_$LoadNavigationTree> get copyWith =>
      __$$LoadNavigationTreeCopyWithImpl<_$LoadNavigationTree>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<MultiChildNavigationNodeData> directories)
        load,
    required TResult Function(NavigationTreeNodeData node) selectNode,
    required TResult Function(String path) selectNodeByPath,
    required TResult Function(String searchQuery) filterNodes,
    required TResult Function() resetNodesFilters,
  }) {
    return load(directories);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<MultiChildNavigationNodeData> directories)? load,
    TResult? Function(NavigationTreeNodeData node)? selectNode,
    TResult? Function(String path)? selectNodeByPath,
    TResult? Function(String searchQuery)? filterNodes,
    TResult? Function()? resetNodesFilters,
  }) {
    return load?.call(directories);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<MultiChildNavigationNodeData> directories)? load,
    TResult Function(NavigationTreeNodeData node)? selectNode,
    TResult Function(String path)? selectNodeByPath,
    TResult Function(String searchQuery)? filterNodes,
    TResult Function()? resetNodesFilters,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(directories);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadNavigationTree value) load,
    required TResult Function(SelectNavigationNode value) selectNode,
    required TResult Function(SelectNavigationNodeByPath value)
        selectNodeByPath,
    required TResult Function(FilterNavigationNodes value) filterNodes,
    required TResult Function(ResetNodesFilter value) resetNodesFilters,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadNavigationTree value)? load,
    TResult? Function(SelectNavigationNode value)? selectNode,
    TResult? Function(SelectNavigationNodeByPath value)? selectNodeByPath,
    TResult? Function(FilterNavigationNodes value)? filterNodes,
    TResult? Function(ResetNodesFilter value)? resetNodesFilters,
  }) {
    return load?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadNavigationTree value)? load,
    TResult Function(SelectNavigationNode value)? selectNode,
    TResult Function(SelectNavigationNodeByPath value)? selectNodeByPath,
    TResult Function(FilterNavigationNodes value)? filterNodes,
    TResult Function(ResetNodesFilter value)? resetNodesFilters,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(this);
    }
    return orElse();
  }
}

abstract class LoadNavigationTree implements NavigationEvent {
  const factory LoadNavigationTree(
          {required final List<MultiChildNavigationNodeData> directories}) =
      _$LoadNavigationTree;

  List<MultiChildNavigationNodeData> get directories;
  @JsonKey(ignore: true)
  _$$LoadNavigationTreeCopyWith<_$LoadNavigationTree> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SelectNavigationNodeCopyWith<$Res> {
  factory _$$SelectNavigationNodeCopyWith(_$SelectNavigationNode value,
          $Res Function(_$SelectNavigationNode) then) =
      __$$SelectNavigationNodeCopyWithImpl<$Res>;
  @useResult
  $Res call({NavigationTreeNodeData node});

  $NavigationTreeNodeDataCopyWith<$Res> get node;
}

/// @nodoc
class __$$SelectNavigationNodeCopyWithImpl<$Res>
    extends _$NavigationEventCopyWithImpl<$Res, _$SelectNavigationNode>
    implements _$$SelectNavigationNodeCopyWith<$Res> {
  __$$SelectNavigationNodeCopyWithImpl(_$SelectNavigationNode _value,
      $Res Function(_$SelectNavigationNode) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? node = null,
  }) {
    return _then(_$SelectNavigationNode(
      node: null == node
          ? _value.node
          : node // ignore: cast_nullable_to_non_nullable
              as NavigationTreeNodeData,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $NavigationTreeNodeDataCopyWith<$Res> get node {
    return $NavigationTreeNodeDataCopyWith<$Res>(_value.node, (value) {
      return _then(_value.copyWith(node: value));
    });
  }
}

/// @nodoc

class _$SelectNavigationNode implements SelectNavigationNode {
  const _$SelectNavigationNode({required this.node});

  @override
  final NavigationTreeNodeData node;

  @override
  String toString() {
    return 'NavigationEvent.selectNode(node: $node)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectNavigationNode &&
            (identical(other.node, node) || other.node == node));
  }

  @override
  int get hashCode => Object.hash(runtimeType, node);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectNavigationNodeCopyWith<_$SelectNavigationNode> get copyWith =>
      __$$SelectNavigationNodeCopyWithImpl<_$SelectNavigationNode>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<MultiChildNavigationNodeData> directories)
        load,
    required TResult Function(NavigationTreeNodeData node) selectNode,
    required TResult Function(String path) selectNodeByPath,
    required TResult Function(String searchQuery) filterNodes,
    required TResult Function() resetNodesFilters,
  }) {
    return selectNode(node);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<MultiChildNavigationNodeData> directories)? load,
    TResult? Function(NavigationTreeNodeData node)? selectNode,
    TResult? Function(String path)? selectNodeByPath,
    TResult? Function(String searchQuery)? filterNodes,
    TResult? Function()? resetNodesFilters,
  }) {
    return selectNode?.call(node);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<MultiChildNavigationNodeData> directories)? load,
    TResult Function(NavigationTreeNodeData node)? selectNode,
    TResult Function(String path)? selectNodeByPath,
    TResult Function(String searchQuery)? filterNodes,
    TResult Function()? resetNodesFilters,
    required TResult orElse(),
  }) {
    if (selectNode != null) {
      return selectNode(node);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadNavigationTree value) load,
    required TResult Function(SelectNavigationNode value) selectNode,
    required TResult Function(SelectNavigationNodeByPath value)
        selectNodeByPath,
    required TResult Function(FilterNavigationNodes value) filterNodes,
    required TResult Function(ResetNodesFilter value) resetNodesFilters,
  }) {
    return selectNode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadNavigationTree value)? load,
    TResult? Function(SelectNavigationNode value)? selectNode,
    TResult? Function(SelectNavigationNodeByPath value)? selectNodeByPath,
    TResult? Function(FilterNavigationNodes value)? filterNodes,
    TResult? Function(ResetNodesFilter value)? resetNodesFilters,
  }) {
    return selectNode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadNavigationTree value)? load,
    TResult Function(SelectNavigationNode value)? selectNode,
    TResult Function(SelectNavigationNodeByPath value)? selectNodeByPath,
    TResult Function(FilterNavigationNodes value)? filterNodes,
    TResult Function(ResetNodesFilter value)? resetNodesFilters,
    required TResult orElse(),
  }) {
    if (selectNode != null) {
      return selectNode(this);
    }
    return orElse();
  }
}

abstract class SelectNavigationNode implements NavigationEvent {
  const factory SelectNavigationNode(
      {required final NavigationTreeNodeData node}) = _$SelectNavigationNode;

  NavigationTreeNodeData get node;
  @JsonKey(ignore: true)
  _$$SelectNavigationNodeCopyWith<_$SelectNavigationNode> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SelectNavigationNodeByPathCopyWith<$Res> {
  factory _$$SelectNavigationNodeByPathCopyWith(
          _$SelectNavigationNodeByPath value,
          $Res Function(_$SelectNavigationNodeByPath) then) =
      __$$SelectNavigationNodeByPathCopyWithImpl<$Res>;
  @useResult
  $Res call({String path});
}

/// @nodoc
class __$$SelectNavigationNodeByPathCopyWithImpl<$Res>
    extends _$NavigationEventCopyWithImpl<$Res, _$SelectNavigationNodeByPath>
    implements _$$SelectNavigationNodeByPathCopyWith<$Res> {
  __$$SelectNavigationNodeByPathCopyWithImpl(
      _$SelectNavigationNodeByPath _value,
      $Res Function(_$SelectNavigationNodeByPath) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
  }) {
    return _then(_$SelectNavigationNodeByPath(
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SelectNavigationNodeByPath implements SelectNavigationNodeByPath {
  const _$SelectNavigationNodeByPath({required this.path});

  @override
  final String path;

  @override
  String toString() {
    return 'NavigationEvent.selectNodeByPath(path: $path)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectNavigationNodeByPath &&
            (identical(other.path, path) || other.path == path));
  }

  @override
  int get hashCode => Object.hash(runtimeType, path);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectNavigationNodeByPathCopyWith<_$SelectNavigationNodeByPath>
      get copyWith => __$$SelectNavigationNodeByPathCopyWithImpl<
          _$SelectNavigationNodeByPath>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<MultiChildNavigationNodeData> directories)
        load,
    required TResult Function(NavigationTreeNodeData node) selectNode,
    required TResult Function(String path) selectNodeByPath,
    required TResult Function(String searchQuery) filterNodes,
    required TResult Function() resetNodesFilters,
  }) {
    return selectNodeByPath(path);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<MultiChildNavigationNodeData> directories)? load,
    TResult? Function(NavigationTreeNodeData node)? selectNode,
    TResult? Function(String path)? selectNodeByPath,
    TResult? Function(String searchQuery)? filterNodes,
    TResult? Function()? resetNodesFilters,
  }) {
    return selectNodeByPath?.call(path);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<MultiChildNavigationNodeData> directories)? load,
    TResult Function(NavigationTreeNodeData node)? selectNode,
    TResult Function(String path)? selectNodeByPath,
    TResult Function(String searchQuery)? filterNodes,
    TResult Function()? resetNodesFilters,
    required TResult orElse(),
  }) {
    if (selectNodeByPath != null) {
      return selectNodeByPath(path);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadNavigationTree value) load,
    required TResult Function(SelectNavigationNode value) selectNode,
    required TResult Function(SelectNavigationNodeByPath value)
        selectNodeByPath,
    required TResult Function(FilterNavigationNodes value) filterNodes,
    required TResult Function(ResetNodesFilter value) resetNodesFilters,
  }) {
    return selectNodeByPath(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadNavigationTree value)? load,
    TResult? Function(SelectNavigationNode value)? selectNode,
    TResult? Function(SelectNavigationNodeByPath value)? selectNodeByPath,
    TResult? Function(FilterNavigationNodes value)? filterNodes,
    TResult? Function(ResetNodesFilter value)? resetNodesFilters,
  }) {
    return selectNodeByPath?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadNavigationTree value)? load,
    TResult Function(SelectNavigationNode value)? selectNode,
    TResult Function(SelectNavigationNodeByPath value)? selectNodeByPath,
    TResult Function(FilterNavigationNodes value)? filterNodes,
    TResult Function(ResetNodesFilter value)? resetNodesFilters,
    required TResult orElse(),
  }) {
    if (selectNodeByPath != null) {
      return selectNodeByPath(this);
    }
    return orElse();
  }
}

abstract class SelectNavigationNodeByPath implements NavigationEvent {
  const factory SelectNavigationNodeByPath({required final String path}) =
      _$SelectNavigationNodeByPath;

  String get path;
  @JsonKey(ignore: true)
  _$$SelectNavigationNodeByPathCopyWith<_$SelectNavigationNodeByPath>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FilterNavigationNodesCopyWith<$Res> {
  factory _$$FilterNavigationNodesCopyWith(_$FilterNavigationNodes value,
          $Res Function(_$FilterNavigationNodes) then) =
      __$$FilterNavigationNodesCopyWithImpl<$Res>;
  @useResult
  $Res call({String searchQuery});
}

/// @nodoc
class __$$FilterNavigationNodesCopyWithImpl<$Res>
    extends _$NavigationEventCopyWithImpl<$Res, _$FilterNavigationNodes>
    implements _$$FilterNavigationNodesCopyWith<$Res> {
  __$$FilterNavigationNodesCopyWithImpl(_$FilterNavigationNodes _value,
      $Res Function(_$FilterNavigationNodes) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchQuery = null,
  }) {
    return _then(_$FilterNavigationNodes(
      searchQuery: null == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FilterNavigationNodes implements FilterNavigationNodes {
  const _$FilterNavigationNodes({required this.searchQuery});

  @override
  final String searchQuery;

  @override
  String toString() {
    return 'NavigationEvent.filterNodes(searchQuery: $searchQuery)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilterNavigationNodes &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery));
  }

  @override
  int get hashCode => Object.hash(runtimeType, searchQuery);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FilterNavigationNodesCopyWith<_$FilterNavigationNodes> get copyWith =>
      __$$FilterNavigationNodesCopyWithImpl<_$FilterNavigationNodes>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<MultiChildNavigationNodeData> directories)
        load,
    required TResult Function(NavigationTreeNodeData node) selectNode,
    required TResult Function(String path) selectNodeByPath,
    required TResult Function(String searchQuery) filterNodes,
    required TResult Function() resetNodesFilters,
  }) {
    return filterNodes(searchQuery);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<MultiChildNavigationNodeData> directories)? load,
    TResult? Function(NavigationTreeNodeData node)? selectNode,
    TResult? Function(String path)? selectNodeByPath,
    TResult? Function(String searchQuery)? filterNodes,
    TResult? Function()? resetNodesFilters,
  }) {
    return filterNodes?.call(searchQuery);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<MultiChildNavigationNodeData> directories)? load,
    TResult Function(NavigationTreeNodeData node)? selectNode,
    TResult Function(String path)? selectNodeByPath,
    TResult Function(String searchQuery)? filterNodes,
    TResult Function()? resetNodesFilters,
    required TResult orElse(),
  }) {
    if (filterNodes != null) {
      return filterNodes(searchQuery);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadNavigationTree value) load,
    required TResult Function(SelectNavigationNode value) selectNode,
    required TResult Function(SelectNavigationNodeByPath value)
        selectNodeByPath,
    required TResult Function(FilterNavigationNodes value) filterNodes,
    required TResult Function(ResetNodesFilter value) resetNodesFilters,
  }) {
    return filterNodes(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadNavigationTree value)? load,
    TResult? Function(SelectNavigationNode value)? selectNode,
    TResult? Function(SelectNavigationNodeByPath value)? selectNodeByPath,
    TResult? Function(FilterNavigationNodes value)? filterNodes,
    TResult? Function(ResetNodesFilter value)? resetNodesFilters,
  }) {
    return filterNodes?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadNavigationTree value)? load,
    TResult Function(SelectNavigationNode value)? selectNode,
    TResult Function(SelectNavigationNodeByPath value)? selectNodeByPath,
    TResult Function(FilterNavigationNodes value)? filterNodes,
    TResult Function(ResetNodesFilter value)? resetNodesFilters,
    required TResult orElse(),
  }) {
    if (filterNodes != null) {
      return filterNodes(this);
    }
    return orElse();
  }
}

abstract class FilterNavigationNodes implements NavigationEvent {
  const factory FilterNavigationNodes({required final String searchQuery}) =
      _$FilterNavigationNodes;

  String get searchQuery;
  @JsonKey(ignore: true)
  _$$FilterNavigationNodesCopyWith<_$FilterNavigationNodes> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ResetNodesFilterCopyWith<$Res> {
  factory _$$ResetNodesFilterCopyWith(
          _$ResetNodesFilter value, $Res Function(_$ResetNodesFilter) then) =
      __$$ResetNodesFilterCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ResetNodesFilterCopyWithImpl<$Res>
    extends _$NavigationEventCopyWithImpl<$Res, _$ResetNodesFilter>
    implements _$$ResetNodesFilterCopyWith<$Res> {
  __$$ResetNodesFilterCopyWithImpl(
      _$ResetNodesFilter _value, $Res Function(_$ResetNodesFilter) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ResetNodesFilter implements ResetNodesFilter {
  const _$ResetNodesFilter();

  @override
  String toString() {
    return 'NavigationEvent.resetNodesFilters()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ResetNodesFilter);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<MultiChildNavigationNodeData> directories)
        load,
    required TResult Function(NavigationTreeNodeData node) selectNode,
    required TResult Function(String path) selectNodeByPath,
    required TResult Function(String searchQuery) filterNodes,
    required TResult Function() resetNodesFilters,
  }) {
    return resetNodesFilters();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<MultiChildNavigationNodeData> directories)? load,
    TResult? Function(NavigationTreeNodeData node)? selectNode,
    TResult? Function(String path)? selectNodeByPath,
    TResult? Function(String searchQuery)? filterNodes,
    TResult? Function()? resetNodesFilters,
  }) {
    return resetNodesFilters?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<MultiChildNavigationNodeData> directories)? load,
    TResult Function(NavigationTreeNodeData node)? selectNode,
    TResult Function(String path)? selectNodeByPath,
    TResult Function(String searchQuery)? filterNodes,
    TResult Function()? resetNodesFilters,
    required TResult orElse(),
  }) {
    if (resetNodesFilters != null) {
      return resetNodesFilters();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadNavigationTree value) load,
    required TResult Function(SelectNavigationNode value) selectNode,
    required TResult Function(SelectNavigationNodeByPath value)
        selectNodeByPath,
    required TResult Function(FilterNavigationNodes value) filterNodes,
    required TResult Function(ResetNodesFilter value) resetNodesFilters,
  }) {
    return resetNodesFilters(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadNavigationTree value)? load,
    TResult? Function(SelectNavigationNode value)? selectNode,
    TResult? Function(SelectNavigationNodeByPath value)? selectNodeByPath,
    TResult? Function(FilterNavigationNodes value)? filterNodes,
    TResult? Function(ResetNodesFilter value)? resetNodesFilters,
  }) {
    return resetNodesFilters?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadNavigationTree value)? load,
    TResult Function(SelectNavigationNode value)? selectNode,
    TResult Function(SelectNavigationNodeByPath value)? selectNodeByPath,
    TResult Function(FilterNavigationNodes value)? filterNodes,
    TResult Function(ResetNodesFilter value)? resetNodesFilters,
    required TResult orElse(),
  }) {
    if (resetNodesFilters != null) {
      return resetNodesFilters(this);
    }
    return orElse();
  }
}

abstract class ResetNodesFilter implements NavigationEvent {
  const factory ResetNodesFilter() = _$ResetNodesFilter;
}

/// @nodoc
mixin _$NavigationState {
  List<NavigationTreeNodeData> get nodes => throw _privateConstructorUsedError;
  List<NavigationTreeNodeData> get filteredNodes =>
      throw _privateConstructorUsedError;
  NavigationTreeNodeData? get selectedNode =>
      throw _privateConstructorUsedError;
  String get searchQuery => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NavigationStateCopyWith<NavigationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NavigationStateCopyWith<$Res> {
  factory $NavigationStateCopyWith(
          NavigationState value, $Res Function(NavigationState) then) =
      _$NavigationStateCopyWithImpl<$Res, NavigationState>;
  @useResult
  $Res call(
      {List<NavigationTreeNodeData> nodes,
      List<NavigationTreeNodeData> filteredNodes,
      NavigationTreeNodeData? selectedNode,
      String searchQuery});

  $NavigationTreeNodeDataCopyWith<$Res>? get selectedNode;
}

/// @nodoc
class _$NavigationStateCopyWithImpl<$Res, $Val extends NavigationState>
    implements $NavigationStateCopyWith<$Res> {
  _$NavigationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nodes = null,
    Object? filteredNodes = null,
    Object? selectedNode = freezed,
    Object? searchQuery = null,
  }) {
    return _then(_value.copyWith(
      nodes: null == nodes
          ? _value.nodes
          : nodes // ignore: cast_nullable_to_non_nullable
              as List<NavigationTreeNodeData>,
      filteredNodes: null == filteredNodes
          ? _value.filteredNodes
          : filteredNodes // ignore: cast_nullable_to_non_nullable
              as List<NavigationTreeNodeData>,
      selectedNode: freezed == selectedNode
          ? _value.selectedNode
          : selectedNode // ignore: cast_nullable_to_non_nullable
              as NavigationTreeNodeData?,
      searchQuery: null == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $NavigationTreeNodeDataCopyWith<$Res>? get selectedNode {
    if (_value.selectedNode == null) {
      return null;
    }

    return $NavigationTreeNodeDataCopyWith<$Res>(_value.selectedNode!, (value) {
      return _then(_value.copyWith(selectedNode: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_NavigationStateCopyWith<$Res>
    implements $NavigationStateCopyWith<$Res> {
  factory _$$_NavigationStateCopyWith(
          _$_NavigationState value, $Res Function(_$_NavigationState) then) =
      __$$_NavigationStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<NavigationTreeNodeData> nodes,
      List<NavigationTreeNodeData> filteredNodes,
      NavigationTreeNodeData? selectedNode,
      String searchQuery});

  @override
  $NavigationTreeNodeDataCopyWith<$Res>? get selectedNode;
}

/// @nodoc
class __$$_NavigationStateCopyWithImpl<$Res>
    extends _$NavigationStateCopyWithImpl<$Res, _$_NavigationState>
    implements _$$_NavigationStateCopyWith<$Res> {
  __$$_NavigationStateCopyWithImpl(
      _$_NavigationState _value, $Res Function(_$_NavigationState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nodes = null,
    Object? filteredNodes = null,
    Object? selectedNode = freezed,
    Object? searchQuery = null,
  }) {
    return _then(_$_NavigationState(
      nodes: null == nodes
          ? _value._nodes
          : nodes // ignore: cast_nullable_to_non_nullable
              as List<NavigationTreeNodeData>,
      filteredNodes: null == filteredNodes
          ? _value._filteredNodes
          : filteredNodes // ignore: cast_nullable_to_non_nullable
              as List<NavigationTreeNodeData>,
      selectedNode: freezed == selectedNode
          ? _value.selectedNode
          : selectedNode // ignore: cast_nullable_to_non_nullable
              as NavigationTreeNodeData?,
      searchQuery: null == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_NavigationState implements _NavigationState {
  _$_NavigationState(
      {final List<NavigationTreeNodeData> nodes = const [],
      final List<NavigationTreeNodeData> filteredNodes = const [],
      this.selectedNode,
      this.searchQuery = ''})
      : _nodes = nodes,
        _filteredNodes = filteredNodes;

  final List<NavigationTreeNodeData> _nodes;
  @override
  @JsonKey()
  List<NavigationTreeNodeData> get nodes {
    if (_nodes is EqualUnmodifiableListView) return _nodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_nodes);
  }

  final List<NavigationTreeNodeData> _filteredNodes;
  @override
  @JsonKey()
  List<NavigationTreeNodeData> get filteredNodes {
    if (_filteredNodes is EqualUnmodifiableListView) return _filteredNodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filteredNodes);
  }

  @override
  final NavigationTreeNodeData? selectedNode;
  @override
  @JsonKey()
  final String searchQuery;

  @override
  String toString() {
    return 'NavigationState(nodes: $nodes, filteredNodes: $filteredNodes, selectedNode: $selectedNode, searchQuery: $searchQuery)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NavigationState &&
            const DeepCollectionEquality().equals(other._nodes, _nodes) &&
            const DeepCollectionEquality()
                .equals(other._filteredNodes, _filteredNodes) &&
            (identical(other.selectedNode, selectedNode) ||
                other.selectedNode == selectedNode) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_nodes),
      const DeepCollectionEquality().hash(_filteredNodes),
      selectedNode,
      searchQuery);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NavigationStateCopyWith<_$_NavigationState> get copyWith =>
      __$$_NavigationStateCopyWithImpl<_$_NavigationState>(this, _$identity);
}

abstract class _NavigationState implements NavigationState {
  factory _NavigationState(
      {final List<NavigationTreeNodeData> nodes,
      final List<NavigationTreeNodeData> filteredNodes,
      final NavigationTreeNodeData? selectedNode,
      final String searchQuery}) = _$_NavigationState;

  @override
  List<NavigationTreeNodeData> get nodes;
  @override
  List<NavigationTreeNodeData> get filteredNodes;
  @override
  NavigationTreeNodeData? get selectedNode;
  @override
  String get searchQuery;
  @override
  @JsonKey(ignore: true)
  _$$_NavigationStateCopyWith<_$_NavigationState> get copyWith =>
      throw _privateConstructorUsedError;
}

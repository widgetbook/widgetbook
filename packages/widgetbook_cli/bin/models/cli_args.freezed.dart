// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'cli_args.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CliArgs {
  String get apiKey => throw _privateConstructorUsedError;
  String get branch => throw _privateConstructorUsedError;
  String get commit => throw _privateConstructorUsedError;
  String get gitProvider => throw _privateConstructorUsedError;
  String? get gitHubToken => throw _privateConstructorUsedError;
  String? get prNumber => throw _privateConstructorUsedError;
  String? get baseBranch => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CliArgsCopyWith<CliArgs> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CliArgsCopyWith<$Res> {
  factory $CliArgsCopyWith(CliArgs value, $Res Function(CliArgs) then) =
      _$CliArgsCopyWithImpl<$Res>;
  $Res call(
      {String apiKey,
      String branch,
      String commit,
      String gitProvider,
      String? gitHubToken,
      String? prNumber,
      String? baseBranch,
      String path});
}

/// @nodoc
class _$CliArgsCopyWithImpl<$Res> implements $CliArgsCopyWith<$Res> {
  _$CliArgsCopyWithImpl(this._value, this._then);

  final CliArgs _value;
  // ignore: unused_field
  final $Res Function(CliArgs) _then;

  @override
  $Res call({
    Object? apiKey = freezed,
    Object? branch = freezed,
    Object? commit = freezed,
    Object? gitProvider = freezed,
    Object? gitHubToken = freezed,
    Object? prNumber = freezed,
    Object? baseBranch = freezed,
    Object? path = freezed,
  }) {
    return _then(_value.copyWith(
      apiKey: apiKey == freezed
          ? _value.apiKey
          : apiKey // ignore: cast_nullable_to_non_nullable
              as String,
      branch: branch == freezed
          ? _value.branch
          : branch // ignore: cast_nullable_to_non_nullable
              as String,
      commit: commit == freezed
          ? _value.commit
          : commit // ignore: cast_nullable_to_non_nullable
              as String,
      gitProvider: gitProvider == freezed
          ? _value.gitProvider
          : gitProvider // ignore: cast_nullable_to_non_nullable
              as String,
      gitHubToken: gitHubToken == freezed
          ? _value.gitHubToken
          : gitHubToken // ignore: cast_nullable_to_non_nullable
              as String?,
      prNumber: prNumber == freezed
          ? _value.prNumber
          : prNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      baseBranch: baseBranch == freezed
          ? _value.baseBranch
          : baseBranch // ignore: cast_nullable_to_non_nullable
              as String?,
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_CliArgsCopyWith<$Res> implements $CliArgsCopyWith<$Res> {
  factory _$$_CliArgsCopyWith(
          _$_CliArgs value, $Res Function(_$_CliArgs) then) =
      __$$_CliArgsCopyWithImpl<$Res>;
  @override
  $Res call(
      {String apiKey,
      String branch,
      String commit,
      String gitProvider,
      String? gitHubToken,
      String? prNumber,
      String? baseBranch,
      String path});
}

/// @nodoc
class __$$_CliArgsCopyWithImpl<$Res> extends _$CliArgsCopyWithImpl<$Res>
    implements _$$_CliArgsCopyWith<$Res> {
  __$$_CliArgsCopyWithImpl(_$_CliArgs _value, $Res Function(_$_CliArgs) _then)
      : super(_value, (v) => _then(v as _$_CliArgs));

  @override
  _$_CliArgs get _value => super._value as _$_CliArgs;

  @override
  $Res call({
    Object? apiKey = freezed,
    Object? branch = freezed,
    Object? commit = freezed,
    Object? gitProvider = freezed,
    Object? gitHubToken = freezed,
    Object? prNumber = freezed,
    Object? baseBranch = freezed,
    Object? path = freezed,
  }) {
    return _then(_$_CliArgs(
      apiKey: apiKey == freezed
          ? _value.apiKey
          : apiKey // ignore: cast_nullable_to_non_nullable
              as String,
      branch: branch == freezed
          ? _value.branch
          : branch // ignore: cast_nullable_to_non_nullable
              as String,
      commit: commit == freezed
          ? _value.commit
          : commit // ignore: cast_nullable_to_non_nullable
              as String,
      gitProvider: gitProvider == freezed
          ? _value.gitProvider
          : gitProvider // ignore: cast_nullable_to_non_nullable
              as String,
      gitHubToken: gitHubToken == freezed
          ? _value.gitHubToken
          : gitHubToken // ignore: cast_nullable_to_non_nullable
              as String?,
      prNumber: prNumber == freezed
          ? _value.prNumber
          : prNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      baseBranch: baseBranch == freezed
          ? _value.baseBranch
          : baseBranch // ignore: cast_nullable_to_non_nullable
              as String?,
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_CliArgs implements _CliArgs {
  _$_CliArgs(
      {required this.apiKey,
      required this.branch,
      required this.commit,
      required this.gitProvider,
      this.gitHubToken,
      this.prNumber,
      this.baseBranch,
      required this.path});

  @override
  final String apiKey;
  @override
  final String branch;
  @override
  final String commit;
  @override
  final String gitProvider;
  @override
  final String? gitHubToken;
  @override
  final String? prNumber;
  @override
  final String? baseBranch;
  @override
  final String path;

  @override
  String toString() {
    return 'CliArgs(apiKey: $apiKey, branch: $branch, commit: $commit, gitProvider: $gitProvider, gitHubToken: $gitHubToken, prNumber: $prNumber, baseBranch: $baseBranch, path: $path)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CliArgs &&
            const DeepCollectionEquality().equals(other.apiKey, apiKey) &&
            const DeepCollectionEquality().equals(other.branch, branch) &&
            const DeepCollectionEquality().equals(other.commit, commit) &&
            const DeepCollectionEquality()
                .equals(other.gitProvider, gitProvider) &&
            const DeepCollectionEquality()
                .equals(other.gitHubToken, gitHubToken) &&
            const DeepCollectionEquality().equals(other.prNumber, prNumber) &&
            const DeepCollectionEquality()
                .equals(other.baseBranch, baseBranch) &&
            const DeepCollectionEquality().equals(other.path, path));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(apiKey),
      const DeepCollectionEquality().hash(branch),
      const DeepCollectionEquality().hash(commit),
      const DeepCollectionEquality().hash(gitProvider),
      const DeepCollectionEquality().hash(gitHubToken),
      const DeepCollectionEquality().hash(prNumber),
      const DeepCollectionEquality().hash(baseBranch),
      const DeepCollectionEquality().hash(path));

  @JsonKey(ignore: true)
  @override
  _$$_CliArgsCopyWith<_$_CliArgs> get copyWith =>
      __$$_CliArgsCopyWithImpl<_$_CliArgs>(this, _$identity);
}

abstract class _CliArgs implements CliArgs {
  factory _CliArgs(
      {required final String apiKey,
      required final String branch,
      required final String commit,
      required final String gitProvider,
      final String? gitHubToken,
      final String? prNumber,
      final String? baseBranch,
      required final String path}) = _$_CliArgs;

  @override
  String get apiKey => throw _privateConstructorUsedError;
  @override
  String get branch => throw _privateConstructorUsedError;
  @override
  String get commit => throw _privateConstructorUsedError;
  @override
  String get gitProvider => throw _privateConstructorUsedError;
  @override
  String? get gitHubToken => throw _privateConstructorUsedError;
  @override
  String? get prNumber => throw _privateConstructorUsedError;
  @override
  String? get baseBranch => throw _privateConstructorUsedError;
  @override
  String get path => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_CliArgsCopyWith<_$_CliArgs> get copyWith =>
      throw _privateConstructorUsedError;
}

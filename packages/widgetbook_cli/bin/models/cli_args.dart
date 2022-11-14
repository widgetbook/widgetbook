import 'package:freezed_annotation/freezed_annotation.dart';

part 'cli_args.freezed.dart';

@freezed
class CliArgs with _$CliArgs {
  factory CliArgs({
    required String apiKey,
    required String branch,
    required String commit,
    required String gitProvider,
    String? gitHubToken,
    String? prNumber,
    String? baseBranch,
    required String path,
  }) = _CliArgs;
}

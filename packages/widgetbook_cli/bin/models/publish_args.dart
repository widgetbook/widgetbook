import 'package:freezed_annotation/freezed_annotation.dart';

part 'publish_args.freezed.dart';

@freezed
class PublishArgs with _$PublishArgs {
  factory PublishArgs({
    required String apiKey,
    required String branch,
    required String commit,
    required String gitProvider,
    required String path,
    required String vendor,
    required String actor,
    required String repository,
    String? gitHubToken,
    String? prNumber,
    // TODO instead of having this as two separate values we should use
    // BranchReference instead. However, this is currently not well implemented
    String? baseBranch,
    String? baseSha,
  }) = _PublishArgs;
}

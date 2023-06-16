import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_build_request.freezed.dart';
part 'create_build_request.g.dart';

@freezed
class CreateBuildRequest with _$CreateBuildRequest {
  factory CreateBuildRequest({
    required String apiKey,
    required String branchName,
    required String repositoryName,
    required String commitSha,
    required String actor,
    required String provider,
  }) = _CreateBuildRequest;

  factory CreateBuildRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateBuildRequestFromJson(json);
}

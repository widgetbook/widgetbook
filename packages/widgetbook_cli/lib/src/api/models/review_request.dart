import '../../models/changed_use_case.dart';

class ReviewRequest {
  const ReviewRequest({
    required this.apiKey,
    required this.useCases,
    required this.buildId,
    required this.projectId,
    required this.baseBranch,
    required this.headBranch,
    required this.baseSha,
    required this.headSha,
  });

  final String apiKey;
  final List<ChangedUseCase> useCases;
  final String buildId;
  final String projectId;
  final String baseBranch;
  final String headBranch;
  final String baseSha;
  final String headSha;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'apiKey': apiKey,
      'useCases': useCases.map((x) => x.toJson()).toList(),
      'buildId': buildId,
      'projectId': projectId,
      'baseBranch': baseBranch,
      'headBranch': headBranch,
      'baseSha': baseSha,
      'headSha': headSha,
    };
  }
}

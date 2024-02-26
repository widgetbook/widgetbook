import '../../models/changed_use_case.dart';

class ReviewRequest extends ReviewSyncRequest {
  const ReviewRequest({
    required super.apiKey,
    required this.buildId,
    required this.projectId,
    required super.baseBranch,
    required super.headBranch,
    required super.baseSha,
    required super.headSha,
    required this.useCases,
  });

  final String buildId;
  final String projectId;
  final List<ChangedUseCase> useCases;

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'buildId': buildId,
      'projectId': projectId,
      'useCases': useCases.map((e) => e.toJson()).toList(),
    };
  }
}

class ReviewSyncRequest {
  const ReviewSyncRequest({
    required this.apiKey,
    required this.baseBranch,
    required this.headBranch,
    required this.baseSha,
    required this.headSha,
  });

  final String apiKey;
  final String baseBranch;
  final String headBranch;
  final String baseSha;
  final String headSha;

  Map<String, dynamic> toJson() {
    return {
      'apiKey': apiKey,
      'baseBranch': baseBranch,
      'headBranch': headBranch,
      'baseSha': baseSha,
      'headSha': headSha,
    };
  }
}

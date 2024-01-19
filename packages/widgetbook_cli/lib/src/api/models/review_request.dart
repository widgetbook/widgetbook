import '../../models/changed_use_case.dart';

class ReviewRequest extends ReviewRequestNext {
  const ReviewRequest({
    required super.apiKey,
    required super.buildId,
    required this.projectId,
    required super.baseBranch,
    required super.headBranch,
    required super.baseSha,
    required super.headSha,
    required this.useCases,
  });

  final String projectId;
  final List<ChangedUseCase> useCases;

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'projectId': projectId,
      'useCases': useCases.map((e) => e.toJson()).toList(),
    };
  }
}

class ReviewRequestNext {
  const ReviewRequestNext({
    required this.apiKey,
    required this.buildId,
    required this.baseBranch,
    required this.headBranch,
    required this.baseSha,
    required this.headSha,
  });

  final String apiKey;
  final String buildId;
  final String baseBranch;
  final String headBranch;
  final String baseSha;
  final String headSha;

  Map<String, dynamic> toJson() {
    return {
      'apiKey': apiKey,
      'buildId': buildId,
      'baseBranch': baseBranch,
      'headBranch': headBranch,
      'baseSha': baseSha,
      'headSha': headSha,
    };
  }
}

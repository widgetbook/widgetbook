import '../../models/changed_use_case.dart';

class ReviewRequest extends ReviewRequestNext {
  const ReviewRequest({
    required super.apiKey,
    required super.buildId,
    required super.projectId,
    required super.baseBranch,
    required super.headBranch,
    required super.baseSha,
    required super.headSha,
    required this.useCases,
  });

  final List<ChangedUseCase> useCases;

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'useCases': useCases.map((e) => e.toJson()).toList(),
    };
  }
}

class ReviewRequestNext {
  const ReviewRequestNext({
    required this.apiKey,
    required this.buildId,
    required this.projectId,
    required this.baseBranch,
    required this.headBranch,
    required this.baseSha,
    required this.headSha,
  });

  final String apiKey;
  final String buildId;
  final String projectId;
  final String baseBranch;
  final String headBranch;
  final String baseSha;
  final String headSha;

  Map<String, dynamic> toJson() {
    return {
      'apiKey': apiKey,
      'buildId': buildId,
      'projectId': projectId,
      'baseBranch': baseBranch,
      'headBranch': headBranch,
      'baseSha': baseSha,
      'headSha': headSha,
    };
  }
}

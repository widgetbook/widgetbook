import 'changed_use_case.dart';

class CreateUseCasesRequest {
  const CreateUseCasesRequest({
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

  // ignore: sort_constructors_first
  factory CreateUseCasesRequest.fromJson(Map<String, dynamic> map) {
    return CreateUseCasesRequest(
      apiKey: map['apiKey'] as String,
      useCases: List<ChangedUseCase>.from(
        (map['useCases'] as List<dynamic>).map<ChangedUseCase>(
          (x) => ChangedUseCase.fromJson(x as Map<String, dynamic>),
        ),
      ),
      buildId: map['buildId'] as String,
      projectId: map['projectId'] as String,
      baseBranch: map['baseBranch'] as String,
      headBranch: map['headBranch'] as String,
      baseSha: map['baseSha'] as String,
      headSha: map['headSha'] as String,
    );
  }
}

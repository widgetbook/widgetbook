import '../review/use_cases/changed_use_case.dart';

class ReviewData {
  const ReviewData({
    required this.useCases,
    required this.buildId,
    required this.projectId,
    required this.baseSha,
  });

  final List<ChangedUseCase> useCases;
  final String buildId;
  final String projectId;
  final String baseSha;
}

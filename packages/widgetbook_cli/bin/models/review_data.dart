import 'package:freezed_annotation/freezed_annotation.dart';

import '../review/use_cases/models/changed_use_case.dart';

part 'review_data.freezed.dart';

@freezed
class ReviewData with _$ReviewData {
  factory ReviewData({
    required List<ChangedUseCase> useCases,
    required String buildId,
    required String projectId,
    required String baseSha,
  }) = _ReviewData;
}

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../devices/models/device_data.dart';
import '../../locales/models/locale_data.dart';
import '../../text_scale_factors/models/text_scale_factor_data.dart';
import '../../themes/models/theme_data.dart';
import '../models/changed_use_case.dart';

part 'create_use_cases_request.freezed.dart';
part 'create_use_cases_request.g.dart';

@freezed
class CreateUseCasesRequest with _$CreateUseCasesRequest {
  factory CreateUseCasesRequest({
    required String apiKey,
    required List<ChangedUseCase> useCases,
    required String buildId,
    required String projectId,
    required String baseBranch,
    required String headBranch,
    required String baseSha,
    required String headSha,
    required List<ThemeData> themes,
    required List<LocaleData> locales,
    required List<DeviceData> devices,
    required List<TextScaleFactorData> textScaleFactors,
  }) = _CreateUseCasesRequest;

  factory CreateUseCasesRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateUseCasesRequestFromJson(json);
}

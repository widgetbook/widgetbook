import 'package:freezed_annotation/freezed_annotation.dart';

import '../review/devices/models/device_data.dart';
import '../review/locales/models/locale_data.dart';
import '../review/text_scale_factors/models/text_scale_factor_data.dart';
import '../review/themes/models/theme_data.dart';

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
    required List<ThemeData> themes,
    required List<LocaleData> locales,
    required List<DeviceData> devices,
    required List<TextScaleFactorData> textScaleFactors,
  }) = _CreateBuildRequest;

  factory CreateBuildRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateBuildRequestFromJson(json);
}

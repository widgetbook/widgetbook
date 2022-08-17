import 'package:freezed_annotation/freezed_annotation.dart';

import '../review/devices/models/device_data.dart';
import '../review/locales/models/locale_data.dart';
import '../review/text_scale_factors/models/text_scale_factor_data.dart';
import '../review/themes/models/theme_data.dart';

part 'deployment_data.freezed.dart';

@freezed
class DeploymentData with _$DeploymentData {
  factory DeploymentData({
    required String apiKey,
    required String branchName,
    required String repositoryName,
    required String commitSha,
    required String actor,
    required String provider,
    List<ThemeData>? themes,
    List<DeviceData>? devices,
    List<LocaleData>? locales,
    List<TextScaleFactorData>? textScaleFactors,
  }) = _DeploymentData;
}

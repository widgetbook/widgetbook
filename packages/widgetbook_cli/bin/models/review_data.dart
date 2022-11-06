import 'package:freezed_annotation/freezed_annotation.dart';

import '../review/devices/models/device_data.dart';
import '../review/locales/models/locale_data.dart';
import '../review/text_scale_factors/models/text_scale_factor_data.dart';
import '../review/themes/models/theme_data.dart';
import '../review/use_cases/models/changed_use_case.dart';

part 'review_data.freezed.dart';

@freezed
class ReviewData with _$ReviewData {
  factory ReviewData({
    required List<ChangedUseCase> useCases,
    required String buildId,
    required String projectId,
    required String baseSha,
    required List<ThemeData> themes,
    required List<LocaleData> locales,
    required List<DeviceData> devices,
    required List<TextScaleFactorData> textScaleFactors,
  }) = _ReviewData;
}

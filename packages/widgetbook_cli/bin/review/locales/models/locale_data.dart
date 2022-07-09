import 'package:freezed_annotation/freezed_annotation.dart';

part 'locale_data.freezed.dart';
part 'locale_data.g.dart';

@freezed
class LocaleData with _$LocaleData {
  factory LocaleData({
    required String name,
  }) = _LocaleData;

  factory LocaleData.fromJson(Map<String, dynamic> json) =>
      _$LocaleDataFromJson(json);
}

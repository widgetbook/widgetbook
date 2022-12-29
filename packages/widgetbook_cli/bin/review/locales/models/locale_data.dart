import 'package:freezed_annotation/freezed_annotation.dart';

import 'model.dart';

part 'locale_data.freezed.dart';
part 'locale_data.g.dart';

@freezed
class LocaleData extends Model with _$LocaleData {
  factory LocaleData({
    required String name,
  }) = _LocaleData;

  factory LocaleData.fromJson(Map<String, dynamic> json) =>
      _$LocaleDataFromJson(json);
}

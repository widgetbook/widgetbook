import 'package:freezed_annotation/freezed_annotation.dart';

import '../../locales/models/model.dart';

part 'theme_data.freezed.dart';
part 'theme_data.g.dart';

@freezed
class ThemeData extends Model with _$ThemeData {
  factory ThemeData({
    required String name,
  }) = _ThemeData;

  factory ThemeData.fromJson(Map<String, dynamic> json) =>
      _$ThemeDataFromJson(json);
}

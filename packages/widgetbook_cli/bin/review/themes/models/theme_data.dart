import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_data.freezed.dart';
part 'theme_data.g.dart';

@freezed
class ThemeData with _$ThemeData {
  factory ThemeData({
    required String name,
  }) = _ThemeData;

  factory ThemeData.fromJson(Map<String, dynamic> json) =>
      _$ThemeDataFromJson(json);
}

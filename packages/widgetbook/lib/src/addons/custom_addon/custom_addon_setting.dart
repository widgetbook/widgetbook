import 'package:freezed_annotation/freezed_annotation.dart';

part 'custom_addon_setting.freezed.dart';

@freezed
class CustomAddonSetting<T> with _$CustomAddonSetting<T> {
  factory CustomAddonSetting({
    required Set<T> activeData,
    required List<T> data,
  }) = _CustomAddonSetting;
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook/widgetbook.dart';

part 'sound_addon_setting.freezed.dart';

@freezed
class SoundAddonSetting extends WidgetbookAddOnSetting
    with _$SoundAddonSetting {
  const factory SoundAddonSetting({
    required bool isEnabled,
  }) = _SoundAddonSetting;

  const SoundAddonSetting._();

  @override
  Map<String, String> toQueryParameter() {
    return {
      'sound': isEnabled.toString(),
    };
  }
}

import 'package:addon_example/sound_addon/sound_addon_setting.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as anno;

const soundAddonSetting = SoundAddonSetting(isEnabled: true);

@anno.WidgetbookUseCase(name: 'Default', type: Text)
Widget exampleUseCaseBuilder(BuildContext context) {
  return Text('Sound is: ${context.sound.isEnabled}');
}

@anno.WidgetbookTheme(name: 'Dark')
ThemeData getTheme() => ThemeData.dark();

@anno.WidgetbookAddonAnnotation(
  setting: soundAddonSetting,
)
class SoundAddon extends WidgetbookAddOn<SoundAddonSetting> {
  SoundAddon({
    required SoundAddonSetting setting,
  }) : super(
          name: 'Sound',
          setting: setting,
        );

  @override
  Widget build(BuildContext context) {
    // TODO we should be able to use the knobs here for unique design
    // as an alternative, use settings
    return Switch(
      value: value.isEnabled,
      onChanged: (value) {
        onChanged(
          context,
          this.value.copyWith(isEnabled: value),
        );
      },
    );
  }

  // TODO rename routerData to queryParameters
  // TODO also rename all the functions to properly reflect this
  @override
  SoundAddonSetting settingFromQueryParameters({
    required Map<String, String> queryParameters,
    required setting,
  }) {
    final isEnabled = parseBool(queryParameters['sound']) ?? setting.isEnabled;
    return SoundAddonSetting(isEnabled: isEnabled);
  }
}

bool? parseBool(String? value) {
  if (value == 'true') return true;
  if (value == 'false') return false;
  return null;
}

extension BuildContextExtension on BuildContext {
  SoundAddonSetting get sound => getAddonValue<SoundAddonSetting>()!;
  bool get isSoundEnabled => sound.isEnabled;
}

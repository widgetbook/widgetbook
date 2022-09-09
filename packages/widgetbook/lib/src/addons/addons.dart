import 'package:widgetbook/src/addons/addon.dart';
import 'package:widgetbook/widgetbook.dart';

export './cupertino_theme_addon/addon.dart';
export './cupertino_theme_addon/cupertino_theme_addon.dart';
export './device_addon/device_addon.dart';
export './localization_addon/addon.dart';
export './material_theme_addon/addon.dart';
export './material_theme_addon/material_theme_addon.dart';
export './text_scale_addon/addon.dart';
export './theme_addon/addon.dart';

List<WidgetbookAddOn> configureMaterialAddons({
  required MaterialThemeSetting themeSetting,
  required TextScaleSetting textScaleSetting,
  required LocalizationSetting localizationSetting,
  required DeviceSelection deviceSetting,
}) {
  return [
    MaterialThemeAddon(
      themeSetting: themeSetting,
    ),
    TextScaleAddon(setting: textScaleSetting),
    LocalizationAddon(data: localizationSetting),
    DeviceAddon(data: deviceSetting),
  ];
}

List<WidgetbookAddOn> configureCupertinoAddons({
  required CupertinoThemeSetting themeSetting,
  required TextScaleSetting textScaleSetting,
  required LocalizationSetting localizationSetting,
  required DeviceSelection deviceSetting,
}) {
  return [
    CupertinoThemeAddon(
      themeSetting: themeSetting,
    ),
    TextScaleAddon(setting: textScaleSetting),
    LocalizationAddon(data: localizationSetting),
    DeviceAddon(data: deviceSetting),
  ];
}

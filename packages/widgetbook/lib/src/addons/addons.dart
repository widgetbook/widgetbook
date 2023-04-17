import 'package:widgetbook/widgetbook.dart';

export 'package:widgetbook_addon/src/widgetbook_addon.dart';
export './cupertino_theme_addon/addon.dart';
export './cupertino_theme_addon/cupertino_theme_addon.dart';
export './custom_theme_addon/addon.dart';
export './localization_addon/addon.dart';
export './material_theme_addon/addon.dart';
export './material_theme_addon/material_theme_addon.dart';
export './text_scale_addon/addon.dart';
export './theme_addon/addon.dart';
export './device_addon/addon.dart';

List<WidgetbookAddOn> configureMaterialAddons({
  required MaterialThemeSetting themeSetting,
  required TextScaleSetting textScaleSetting,
  required LocalizationSetting localizationSetting,
  required List<Device> devices,
}) {
  return [
    MaterialThemeAddon(setting: themeSetting),
    TextScaleAddon(setting: textScaleSetting),
    LocalizationAddon(setting: localizationSetting),
    DeviceAddon(devices: devices),
  ];
}

List<WidgetbookAddOn> configureCupertinoAddons({
  required CupertinoThemeSetting themeSetting,
  required TextScaleSetting textScaleSetting,
  required LocalizationSetting localizationSetting,
  required List<Device> devices,
}) {
  return [
    CupertinoThemeAddon(setting: themeSetting),
    TextScaleAddon(setting: textScaleSetting),
    LocalizationAddon(setting: localizationSetting),
    DeviceAddon(devices: devices),
  ];
}

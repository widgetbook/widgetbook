import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

export './common/common.dart';
export './device_addon/addon.dart';
export './localization_addon/addon.dart';
export './text_scale_addon/addon.dart';
export './theme_addon/addon.dart';

List<WidgetbookAddOn> configureMaterialAddons({
  required List<WidgetbookTheme<ThemeData>> themes,
  required List<double> textScales,
  required List<Locale> locales,
  required List<LocalizationsDelegate> localizationsDelegates,
  required List<Device> devices,
}) {
  return [
    MaterialThemeAddon(
      themes: themes,
    ),
    TextScaleAddon(
      scales: textScales,
    ),
    LocalizationAddon(
      locales: locales,
      localizationsDelegates: localizationsDelegates,
    ),
    DeviceAddon(
      devices: devices,
    ),
  ];
}

List<WidgetbookAddOn> configureCupertinoAddons({
  required List<WidgetbookTheme<CupertinoThemeData>> themes,
  required List<double> textScales,
  required List<Locale> locales,
  required List<LocalizationsDelegate> localizationsDelegates,
  required List<Device> devices,
}) {
  return [
    CupertinoThemeAddon(
      themes: themes,
    ),
    TextScaleAddon(
      scales: textScales,
    ),
    LocalizationAddon(
      locales: locales,
      localizationsDelegates: localizationsDelegates,
    ),
    DeviceAddon(
      devices: devices,
    ),
  ];
}

import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:widgetbook/src/addons/addons.dart';

import 'flutter_gen/gen_l10n/app_localizations.dart';

const engLocaleUs = Locale('en', 'US');
const engLocaleGb = Locale('en', 'GB');
const germanLocale = Locale('de');
const frenchLocale = Locale('fr');

const locales = [
  engLocaleUs,
  engLocaleGb,
  germanLocale,
  frenchLocale,
];

List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
  AppLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];

LocalizationSetting localizationSetting = LocalizationSetting(
  activeLocale: engLocaleGb,
  localizationsDelegates: localizationsDelegates,
  locales: locales,
);

LocalizationAddon localizationAddon = LocalizationAddon(
  setting: localizationSetting,
);

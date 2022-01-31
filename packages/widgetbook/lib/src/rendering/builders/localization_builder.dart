import 'package:flutter/material.dart';

LocalizationBuilderFunction get defaultLocalizationBuilder => (
      BuildContext context,
      List<Locale> supportedLocales,
      List<LocalizationsDelegate<dynamic>> localizationsDelegates,
      Locale activeLocale,
      Widget child,
    ) {
      return Localizations(
        locale: activeLocale,
        delegates: localizationsDelegates,
        child: child,
      );
    };

typedef LocalizationBuilderFunction = Widget Function(
  BuildContext context,
  List<Locale> supportedLocales,
  List<LocalizationsDelegate<dynamic>> localizationsDelegates,
  Locale activeLocale,
  Widget child,
);

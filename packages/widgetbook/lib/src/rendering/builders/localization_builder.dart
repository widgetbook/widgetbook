import 'package:flutter/material.dart';

LocalizationBuilderFunction get defaultLocalizationBuilder => (
      BuildContext context,
      List<Locale> supportedLocales,
      List<LocalizationsDelegate<dynamic>>? localizationsDelegates,
      Locale activeLocale,
      Widget child,
    ) {
      if (localizationsDelegates != null) {
        return Localizations(
          locale: activeLocale,
          delegates: localizationsDelegates,
          child: child,
        );
      }

      return child;
    };

typedef LocalizationBuilderFunction = Widget Function(
  BuildContext context,
  List<Locale> supportedLocales,
  List<LocalizationsDelegate<dynamic>>? localizationsDelegates,
  Locale activeLocale,
  Widget child,
);

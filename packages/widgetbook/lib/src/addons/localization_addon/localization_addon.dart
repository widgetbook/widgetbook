import 'package:flutter/material.dart';

import '../../fields/fields.dart';
import '../common/common.dart';
import 'localization_setting.dart';

/// A [WidgetbookAddOn] for changing the active [Locale] via [Localizations].
class LocalizationAddon extends WidgetbookAddOn<LocalizationSetting> {
  LocalizationAddon({
    required List<Locale> locales,
    required List<LocalizationsDelegate> localizationsDelegates,
    Locale? initialLocale,
  })  : assert(
          locales.isNotEmpty,
          'locales cannot be empty',
        ),
        assert(
          initialLocale == null || locales.contains(initialLocale),
          'initialLocale must be in locales',
        ),
        super(
          name: 'Locale',
          initialSetting: LocalizationSetting(
            locales: locales,
            localizationsDelegates: localizationsDelegates,
            activeLocale: initialLocale ?? locales.first,
          ),
        );

  @override
  List<Field> get fields {
    return [
      ListField<Locale>(
        group: slugName,
        name: 'name',
        values: setting.locales,
        initialValue: setting.activeLocale,
        labelBuilder: (locale) => locale.toLanguageTag(),
        onChanged: (_, locale) {
          if (locale == null) return;

          updateSetting(
            setting.copyWith(
              activeLocale: locale,
            ),
          );
        },
      ),
    ];
  }

  @override
  Widget buildUseCase(BuildContext context, Widget child) {
    return Localizations(
      locale: setting.activeLocale,
      delegates: setting.localizationsDelegates,
      child: child,
    );
  }
}

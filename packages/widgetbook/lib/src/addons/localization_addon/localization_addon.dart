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
        values: initialSetting.locales,
        initialValue: initialSetting.activeLocale,
        labelBuilder: (locale) => locale.toLanguageTag(),
      ),
    ];
  }

  @override
  LocalizationSetting settingFromQueryGroup(Map<String, String> group) {
    return LocalizationSetting(
      locales: initialSetting.locales,
      localizationsDelegates: initialSetting.localizationsDelegates,
      activeLocale: initialSetting.locales.firstWhere(
        (locale) => locale.toLanguageTag() == group['name'],
        orElse: () => initialSetting.activeLocale,
      ),
    );
  }

  @override
  Widget buildUseCase(
    BuildContext context,
    Widget child,
    LocalizationSetting setting,
  ) {
    return Localizations(
      locale: setting.activeLocale,
      delegates: setting.localizationsDelegates,
      child: child,
    );
  }
}

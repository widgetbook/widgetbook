import 'package:flutter/material.dart';

import '../../fields/fields.dart';
import '../common/common.dart';

/// A [WidgetbookAddon] for changing the active [Locale] via [Localizations].
class LocalizationAddon extends WidgetbookAddon<Locale> {
  LocalizationAddon({
    required this.locales,
    required this.localizationsDelegates,
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
          initialSetting: initialLocale ?? locales.first,
        );

  final List<Locale> locales;
  final List<LocalizationsDelegate> localizationsDelegates;

  @override
  List<Field> get fields {
    return [
      ListField<Locale>(
        group: slugName,
        name: 'name',
        values: locales,
        initialValue: initialSetting,
        labelBuilder: (locale) => locale.toLanguageTag(),
      ),
    ];
  }

  @override
  Locale settingFromQueryGroup(Map<String, String> group) {
    return locales.firstWhere(
      (locale) => locale.toLanguageTag() == group['name'],
      orElse: () => initialSetting,
    );
  }

  @override
  Widget buildUseCase(
    BuildContext context,
    Widget child,
    Locale setting,
  ) {
    return Localizations(
      locale: setting,
      delegates: localizationsDelegates,
      child: child,
    );
  }
}

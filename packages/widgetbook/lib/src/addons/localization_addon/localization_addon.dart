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
  final List<LocalizationsDelegate<dynamic>> localizationsDelegates;

  @override
  List<Field> get fields {
    return [
      ListField<Locale>(
        name: 'name',
        values: locales,
        initialValue: initialSetting,
        labelBuilder: (locale) => locale.toLanguageTag(),
      ),
    ];
  }

  @override
  Locale valueFromQueryGroup(Map<String, String> group) {
    return valueOf('name', group)!;
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

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../fields/fields.dart';

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
        labelBuilder: (locale) => locale.toLanguageTag(),
        codec: FieldCodec(
          toParam: (locale) => locale.toLanguageTag(),
          toValue: (param) => setting.locales.firstWhere(
            (locale) => locale.toLanguageTag() == param,
            orElse: () => setting.activeLocale,
          ),
        ),
        onChanged: (locale) {
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

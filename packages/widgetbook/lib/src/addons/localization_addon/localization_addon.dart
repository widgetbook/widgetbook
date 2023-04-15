import 'package:flutter/material.dart';
import 'package:widgetbook/src/routing/router.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

class LocalizationAddon extends WidgetbookAddOn<LocalizationSetting> {
  LocalizationAddon({
    required super.setting,
  }) : super(
          name: 'localization',
        );

  @override
  Widget build(BuildContext context) {
    final locales = value.locales;
    final activeLocale = value.activeLocale;

    return Setting(
      name: 'Locale',
      child: DropdownSetting<Locale>(
        options: locales,
        initialSelection: activeLocale,
        optionValueBuilder: (locale) => locale.toString(),
        onSelected: (newLocale) {
          onChanged(context, value.copyWith(activeLocale: newLocale));
        },
      ),
    );
  }

  @override
  void updateQueryParameters(BuildContext context, LocalizationSetting value) {
    context.goTo(queryParams: value.toQueryParameter());
  }

  @override
  LocalizationSetting settingFromQueryParameters({
    required Map<String, String> queryParameters,
    required LocalizationSetting setting,
  }) {
    final activeLocale = parseQueryParameters(
          name: 'locale',
          queryParameters: queryParameters,
          mappedData: {for (var e in setting.locales) e.toString(): e},
        ) ??
        setting.activeLocale;

    return setting.copyWith(activeLocale: activeLocale);
  }
}

extension LocalizationExtension on BuildContext {
  /// Creates adjustable parameters for the WidgetbookUseCase
  LocalizationSetting? get localization => getAddonValue<LocalizationSetting>();
}

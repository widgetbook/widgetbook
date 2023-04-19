import 'package:flutter/material.dart';
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
    return Setting(
      name: 'Locale',
      child: DropdownSetting<Locale>(
        options: setting.locales,
        initialSelection: setting.activeLocale,
        optionValueBuilder: (locale) => locale.toString(),
        onSelected: (locale) {
          onChanged(
            value.copyWith(
              activeLocale: locale,
            ),
          );
        },
      ),
    );
  }
}

extension LocalizationExtension on BuildContext {
  /// Creates adjustable parameters for the WidgetbookUseCase
  LocalizationSetting? get localization => getAddonValue<LocalizationSetting>();
}

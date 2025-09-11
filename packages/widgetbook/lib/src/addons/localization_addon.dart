import 'package:flutter/widgets.dart';

import '../core/addon.dart';
import '../core/mode.dart';
import '../core/mode_addon.dart';
import '../fields/fields.dart';

class LocaleMode extends Mode<Locale> {
  LocaleMode(super.value, this.delegates);

  final List<LocalizationsDelegate<dynamic>> delegates;

  @override
  Widget build(BuildContext context, Widget child) {
    return Localizations(
      locale: value,
      delegates: delegates,
      child: child,
    );
  }
}

/// An [Addon] for changing the active [Locale] via [Localizations].
class LocaleAddon extends ModeAddon<Locale> {
  LocaleAddon(
    this.locales, [
    List<LocalizationsDelegate<dynamic>> delegates = const [],
  ]) : assert(locales.isNotEmpty, 'locales cannot be empty'),
       super(
         name: 'Locale',
         modeBuilder: (locale) => LocaleMode(locale, delegates),
       );

  final List<Locale> locales;

  @override
  List<Field> get fields {
    return [
      ObjectDropdownField<Locale>(
        name: 'name',
        values: locales,
        initialValue: locales.first,
        labelBuilder: (locale) => locale.toLanguageTag(),
      ),
    ];
  }

  @override
  Locale valueFromQueryGroup(Map<String, String> group) {
    return valueOf<Locale>('name', group)!;
  }
}

import 'package:flutter/widgets.dart';

import '../../fields/fields.dart';
import 'base/mode.dart';
import 'base/modes_addon.dart';

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

class LocaleAddon extends ModesAddon<LocaleMode> {
  LocaleAddon(
    this.locales, [
    this.delegates = const [],
  ])  : assert(locales.isNotEmpty, 'locales cannot be empty'),
        super(
          name: 'Locale',
          modes: locales.map((entry) => LocaleMode(entry, delegates)).toList(),
        );

  final List<Locale> locales;
  final List<LocalizationsDelegate<dynamic>> delegates;

  @override
  List<Field> get fields {
    return [
      ListField<Locale>(
        name: 'name',
        values: locales,
        initialValue: locales.first,
        labelBuilder: (locale) => locale.toLanguageTag(),
      ),
    ];
  }

  @override
  LocaleMode valueFromQueryGroup(Map<String, String> group) {
    return LocaleMode(
      valueOf<Locale>('name', group)!,
      delegates,
    );
  }
}

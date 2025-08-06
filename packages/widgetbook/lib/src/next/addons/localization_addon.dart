// next version of Widgetbook doesn't have api docs yet
// ignore_for_file: public_member_api_docs

import 'package:flutter/widgets.dart';

import '../../fields/fields.dart';
import 'base/mode.dart';
import 'base/mode_addon.dart';

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

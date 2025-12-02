import 'package:flutter/widgets.dart';

import '../fields/fields.dart';
import '../framework/framework.dart';

class LocaleMode extends Mode<Locale> {
  LocaleMode(
    Locale value, [
    List<LocalizationsDelegate<dynamic>> delegates = const [],
  ]) : super(value, LocaleAddon([value], delegates));
}

/// An [Addon] for changing the active [Locale] via [Localizations].
class LocaleAddon extends Addon<Locale> with SingleFieldOnly {
  LocaleAddon(
    this.locales, [
    this.delegates = const [],
  ]) : assert(locales.isNotEmpty, 'locales cannot be empty'),
       super(
         name: 'Locale',
         initialValue: locales.first,
       );

  final List<Locale> locales;
  final List<LocalizationsDelegate<dynamic>> delegates;

  @override
  Field<Locale> get field {
    return ObjectDropdownField<Locale>(
      name: 'name',
      values: locales,
      initialValue: initialValue,
      labelBuilder: (locale) => locale.toLanguageTag(),
    );
  }

  @override
  Widget apply(BuildContext context, Widget child, Locale setting) {
    return Localizations(
      locale: setting,
      delegates: delegates,
      child: child,
    );
  }
}

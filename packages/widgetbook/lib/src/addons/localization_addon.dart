import 'package:flutter/widgets.dart';

import '../core/core.dart';
import '../fields/fields.dart';

class LocaleMode extends Mode<Locale> {
  LocaleMode(
    Locale value, [
    List<LocalizationsDelegate<dynamic>> delegates = const [],
  ]) : super(value, LocaleAddon([value], delegates));
}

/// An [Addon] for changing the active [Locale] via [Localizations].
class LocaleAddon extends Addon<Locale> {
  LocaleAddon(
    this.locales, [
    this.delegates = const [],
  ]) : assert(locales.isNotEmpty, 'locales cannot be empty'),
       super(name: 'Locale');

  final List<Locale> locales;
  final List<LocalizationsDelegate<dynamic>> delegates;

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
  Widget buildUseCase(BuildContext context, Widget child, Locale setting) {
    return Localizations(
      locale: setting,
      delegates: delegates,
      child: child,
    );
  }
}

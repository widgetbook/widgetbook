import 'package:flutter/rendering.dart';

import '../../addons/addons.dart';
import 'mode.dart';

class LocalizationMode extends LocalizationAddon with Mode<Locale> {
  LocalizationMode({
    required super.locales,
    required super.localizationsDelegates,
    super.initialLocale,
  });
}

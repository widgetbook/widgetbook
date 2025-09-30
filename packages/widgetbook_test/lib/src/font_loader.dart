import 'package:flutter/services.dart';

import 'font_manifest.dart';

/// Loads all fonts included in pubspec.yaml or dependencies.
///
/// There is no way to easily load the Material or Cupertino fonts.
/// To make them available in tests, an app needs to include
/// their own copies of them.
///
/// Widgetbook supplies Roboto because it is free to use.
Future<void> loadFonts() async {
  final fontManifest = await rootBundle.loadStructuredData(
    'FontManifest.json',
    (json) async => FontManifest.fromJson(json),
  );

  for (final family in fontManifest.families) {
    if (family.name == 'packages/widgetbook/Poppins') {
      // Exclude Poppins font as it is only used in Widgetbook UI
      continue;
    }

    final fontLoader = FontLoader(
      // Localize font names from this package,
      // so that any font included here (e.g. Roboto) works.
      family.name.replaceAll('packages/widgetbook_test/', ''),
    );

    for (final font in family.fonts) {
      final fontBytes = rootBundle.load(font.asset);
      fontLoader.addFont(fontBytes);
    }

    await fontLoader.load();
  }
}

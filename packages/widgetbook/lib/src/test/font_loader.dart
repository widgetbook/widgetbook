/// @docImport 'package:flutter/painting.dart';
library;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'font_manifest.dart';

/// Prefix Flutter gives to font families declared by a dependency package.
const _packagePrefix = 'packages/';

/// Loads all fonts included in pubspec.yaml or dependencies.
///
/// There is no way to easily load the Material or Cupertino fonts.
/// To make them available in tests, an app needs to include
/// their own copies of them.
///
/// Widgetbook supplies Roboto because it is free to use.
///
/// Fonts declared by a dependency package are registered by Flutter under a
/// `packages/<package>/<family>` name, and only resolve for a [TextStyle] that
/// passes a matching `package` argument. A [TextStyle] naming the bare family
/// instead falls back to the test font, which paints every glyph as a filled
/// rectangle. To keep snapshots legible, each package family is also registered
/// under its bare name, unless that name is already claimed by the root package
/// or by another dependency.
Future<void> loadFonts() async {
  final fontManifest = await rootBundle.loadStructuredData(
    'FontManifest.json',
    (json) async => FontManifest.fromJson(json),
  );

  final aliases = bareFamilyAliases(
    fontManifest.families.map((family) => family.name),
  );

  for (final family in fontManifest.families) {
    final names = {
      family.name,
      if (aliases[family.name] case final alias?) alias,
    };

    for (final name in names) {
      final fontLoader = FontLoader(name);

      for (final font in family.fonts) {
        final fontBytes = rootBundle.load(font.asset);
        fontLoader.addFont(fontBytes);
      }

      await fontLoader.load();
    }
  }
}

/// Maps each package-scoped family name onto the bare family name it may
/// safely also be registered under.
///
/// A bare name is only safe when nothing else already resolves under it,
/// otherwise the alias would silently shadow a different typeface.
@visibleForTesting
Map<String, String> bareFamilyAliases(Iterable<String> familyNames) {
  final names = familyNames.toList();
  final rootNames = names
      .where((name) => !name.startsWith(_packagePrefix))
      .toSet();

  final claimants = <String, List<String>>{};
  for (final name in names) {
    if (!name.startsWith(_packagePrefix)) continue;

    final bare = name.split('/').skip(2).join('/');
    if (bare.isEmpty || rootNames.contains(bare)) continue;

    claimants.putIfAbsent(bare, () => []).add(name);
  }

  final aliases = <String, String>{};
  claimants.forEach((bare, contenders) {
    if (contenders.length > 1) {
      debugPrint(
        'Widgetbook: font family "$bare" is declared by multiple packages '
        '(${contenders.join(', ')}). Snapshots will only render it for a '
        'TextStyle that passes the matching `package` argument.',
      );
      return;
    }

    aliases[contenders.single] = bare;
  });

  return aliases;
}

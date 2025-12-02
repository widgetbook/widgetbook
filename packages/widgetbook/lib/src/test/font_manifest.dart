import 'dart:convert';

class FontManifest {
  const FontManifest({
    required this.families,
  });

  final List<_FontFamily> families;

  // ignore: sort_constructors_first
  factory FontManifest.fromJson(String json) {
    final decodedJson = jsonDecode(json) as List<dynamic>;

    return FontManifest(
      families: decodedJson
          .map((e) => _FontFamily.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class _FontFamily {
  const _FontFamily({
    required this.name,
    required this.fonts,
  });

  final String name;
  final List<_FontAsset> fonts;

  // ignore: sort_constructors_first
  factory _FontFamily.fromJson(Map<String, dynamic> json) {
    return _FontFamily(
      name: json['family'] as String,
      fonts: (json['fonts'] as List<dynamic>)
          .map((e) => _FontAsset.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class _FontAsset {
  const _FontAsset({
    required this.asset,
    this.style,
    this.weight,
  });

  final String asset;
  final String? style;
  final int? weight;

  // ignore: sort_constructors_first
  factory _FontAsset.fromJson(Map<String, dynamic> json) {
    return _FontAsset(
      asset: json['asset'] as String,
      style: json['style'] as String?,
      weight: json['weight'] as int?,
    );
  }
}

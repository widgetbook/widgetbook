import 'addon_config.dart';

typedef AddonsConfigs = Map<String, Iterable<AddonConfig>>;

extension AddonsConfigsExtension on AddonsConfigs {
  Map<String, dynamic> toJson() {
    return map(
      (key, value) => MapEntry(
        key,
        Map<String, String>.fromEntries(
          value.map((e) => e.toMapEntry()),
        ),
      ),
    );
  }
}

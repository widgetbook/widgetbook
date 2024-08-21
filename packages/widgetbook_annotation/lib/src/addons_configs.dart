import 'addon_config.dart';

typedef AddonsConfigs = Map<String, List<AddonConfig>>;

extension AddonsConfigsExtension on AddonsConfigs {
  Map<String, dynamic> toJson() {
    return map(
      (key, value) => MapEntry(
        key,
        value.map((e) => e.toMapEntry()).toList(),
      ),
    );
  }
}

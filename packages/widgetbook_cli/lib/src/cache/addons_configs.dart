import 'cache_exception.dart';

typedef AddonsConfigs = Map<String, Map<String, String>>;

AddonsConfigs parseAddonsConfigsJson(Map<String, dynamic> json) {
  try {
    return json.map((key, value) {
      return MapEntry(key, Map<String, String>.from(value as Map));
    });
  } catch (e) {
    throw CacheFormatException('addons configs', json, e);
  }
}

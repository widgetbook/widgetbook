typedef AddonsConfigs = Map<String, Map<String, String>>;

AddonsConfigs parseAddonsConfigsJson(Map<String, dynamic> json) {
  return json.map((key, value) {
    return MapEntry(key, Map<String, String>.from(value as Map));
  });
}

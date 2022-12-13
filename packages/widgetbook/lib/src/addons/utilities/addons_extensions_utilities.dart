import 'package:flutter/material.dart';

extension JsonConverterExtensions on BuildContext {
  String jsonToString({
    required String data,
    required String addonItem,
    String? nestedAddonItem,
  }) {
    final str = data.replaceAll('{', '').replaceAll('}', '').split(',');

    final result = <String, dynamic>{};
    for (var i = 0; i < str.length; i++) {
      final s = str[i].split(':');
      result.putIfAbsent(s[0].trim(), () => s[1].trim());
    }
    return result[addonItem].toString();
  }
}

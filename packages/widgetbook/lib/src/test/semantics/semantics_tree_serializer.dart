import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/rendering.dart';

import 'semantics_data_extension.dart';

class SemanticsTreeSerializer {
  const SemanticsTreeSerializer._();

  static Map<String, dynamic> toJson(SemanticsNode node) {
    final data = node.getSemanticsData();
    final properties = data.toJson();

    final children = <Map<String, dynamic>>[];
    node.visitChildren((child) {
      children.add(toJson(child));
      return true;
    });

    properties['children'] = children;
    properties['hash'] = sha256
        .convert(utf8.encode(jsonEncode(properties)))
        .toString();
    return properties;
  }
}

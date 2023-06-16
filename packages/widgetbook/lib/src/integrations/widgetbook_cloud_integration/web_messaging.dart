// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

@internal
void sendMessage(Map<String, dynamic> json) {
  if (!kIsWeb) return;
  window.parent?.postMessage(json, '*');
}

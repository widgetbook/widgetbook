import 'dart:html';

import 'package:flutter/foundation.dart';

void sendMessage(Map<String, dynamic> json) {
  if (!kIsWeb) return;
  window.parent?.postMessage(json, '*');
}

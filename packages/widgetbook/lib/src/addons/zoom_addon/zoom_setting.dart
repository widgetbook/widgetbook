import 'package:flutter/foundation.dart';

class ZoomSetting {
  ZoomSetting({double? initialScale})
      : scaleNotifier = ValueNotifier<double>(initialScale ?? 1.0);

  final ValueNotifier<double> scaleNotifier;

  void zoomIn() {
    scaleNotifier.value += 0.1;
  }

  void zoomOut() {
    if (scaleNotifier.value > 0.1) {
      scaleNotifier.value -= 0.1;
    }
  }

  void reset() {
    scaleNotifier.value = 1.0;
  }
}

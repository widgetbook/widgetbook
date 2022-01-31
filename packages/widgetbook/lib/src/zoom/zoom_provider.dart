import 'package:flutter/material.dart';
import 'package:widgetbook/src/zoom/zoom_state.dart';

class ZoomProvider with ChangeNotifier {
  ZoomProvider({
    ZoomState? state,
  })  : _state = state ?? ZoomState(),
        super();

  ZoomState _state;

  set state(ZoomState value) {
    _state = value;
    notifyListeners();
  }

  ZoomState get state => _state;

  double get levelChange => 0.25;
  double get minLevel => 0.25;
  double get maxLevel => 5;

  void zoomIn() {
    setScale(state.zoomLevel + levelChange);
  }

  void setScale(double scale) {
    state = state.copyWith(
      zoomLevel: scale.clamp(minLevel, maxLevel),
    );
  }

  void zoomOut() {
    setScale(state.zoomLevel - levelChange);
  }

  void resetToNormal() {
    state = ZoomState();
  }
}

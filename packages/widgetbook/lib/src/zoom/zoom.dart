import 'package:riverpod/riverpod.dart';
import 'package:widgetbook/src/zoom/zoom_state.dart';

final zoomProvider = StateNotifierProvider<ZoomNotifier, ZoomState>((ref) {
  return ZoomNotifier();
});

class ZoomNotifier extends StateNotifier<ZoomState> {
  ZoomNotifier() : super(ZoomState());

  double get levelChange => 0.25;
  double get minLevel => 0.25;
  double get maxLevel => 5;

  void zoomIn() {
    state = state.copyWith(
      zoomLevel: state.zoomLevel + levelChange,
    );
  }

  void setScale(double scale) {
    state = state.copyWith(
      zoomLevel: scale,
    );
  }

  void zoomOut() {
    state = state.copyWith(
      zoomLevel: (state.zoomLevel - levelChange).clamp(
        minLevel,
        maxLevel,
      ),
    );
  }

  void resetToNormal() {
    state = ZoomState();
  }
}

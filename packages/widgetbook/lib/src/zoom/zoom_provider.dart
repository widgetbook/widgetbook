import 'package:widgetbook/src/state_change_notifier.dart';
import 'package:widgetbook/src/zoom/zoom_state.dart';

/// Allows zooming in and out of a device preview
class ZoomProvider extends StateChangeNotifier<ZoomState> {
  ZoomProvider({
    ZoomState? state,
  }) : super(state: state ?? ZoomState());

  /// The change of the zoom leven whenever the zoom in or zoom out button is
  /// pressed
  static const double levelChange = 0.25;

  /// The minimum zoom level allowed
  ///
  /// Limits the zoom level since otherwise the device might not longer be
  /// visible.
  static const double minLevel = 0.25;

  /// The maximum zoom level allowed
  ///
  /// Limits the zoom level since otherwise the device is so huge that no widget
  /// might be visible
  static const double maxLevel = 5;

  /// Changes the current zoom level by adding the provided [change].
  void zoomRelative(double change) {
    setScale(state.zoomLevel + change);
  }

  /// Zooms in the current zoomLevel by [levelChange].
  void zoomIn() {
    setScale(state.zoomLevel + levelChange);
  }

  /// Overrides the current zoom level by [scale].
  ///
  /// The provided value will be clamped to [minLevel] and [maxLevel].
  void setScale(double scale) {
    state = state.copyWith(
      zoomLevel: scale.clamp(minLevel, maxLevel),
    );
  }

  /// Zooms out the current zoomLevel by [levelChange].
  void zoomOut() {
    setScale(state.zoomLevel - levelChange);
  }

  /// Resets the zoom level to the default.
  ///
  /// The default is 1.
  void resetToNormal() {
    state = ZoomState();
  }
}

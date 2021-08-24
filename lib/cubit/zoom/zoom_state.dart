part of 'zoom_cubit.dart';

@immutable
class ZoomState {
  final double zoomLevel;

  ZoomState({
    required this.zoomLevel,
  });

  factory ZoomState.normal() {
    return ZoomState(zoomLevel: 1);
  }
}

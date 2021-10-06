class ZoomState {
  ZoomState({
    required this.zoomLevel,
  });

  factory ZoomState.normal() {
    return ZoomState(zoomLevel: 1);
  }

  final double zoomLevel;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ZoomState && other.zoomLevel == zoomLevel;
  }

  @override
  int get hashCode => zoomLevel.hashCode;
}

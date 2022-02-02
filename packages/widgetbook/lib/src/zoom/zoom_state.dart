import 'package:freezed_annotation/freezed_annotation.dart';

part 'zoom_state.freezed.dart';

@freezed
class ZoomState with _$ZoomState {
  factory ZoomState({
    @Default(1) double zoomLevel,
  }) = _ZoomState;
}

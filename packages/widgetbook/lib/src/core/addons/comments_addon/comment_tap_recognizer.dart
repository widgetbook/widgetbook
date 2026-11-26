import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

/// Claims every pointer down on the story while commenting, so that buttons
/// in the story do not react to it, while scroll wheel and trackpad
/// gestures still scroll the story.
@internal
class CommentTapRecognizer extends OneSequenceGestureRecognizer {
  CommentTapRecognizer({super.debugOwner});

  ValueChanged<Offset>? onTap;

  @override
  void addAllowedPointer(PointerDownEvent event) {
    super.addAllowedPointer(event);
    resolve(GestureDisposition.accepted);
  }

  @override
  void handleEvent(PointerEvent event) {
    if (event is PointerUpEvent) {
      onTap?.call(event.position);
      stopTrackingPointer(event.pointer);
    } else if (event is PointerCancelEvent) {
      stopTrackingPointer(event.pointer);
    }
  }

  @override
  void didStopTrackingLastPointer(int pointer) {}

  @override
  String get debugDescription => 'comment tap';
}

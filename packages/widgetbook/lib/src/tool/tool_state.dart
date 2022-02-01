import 'package:freezed_annotation/freezed_annotation.dart';

part 'tool_state.freezed.dart';

enum SelectionMode {
  normal,
  move,
}

@freezed
class ToolState with _$ToolState {
  factory ToolState({
    @Default(SelectionMode.normal) SelectionMode mode,
  }) = _ToolState;
}

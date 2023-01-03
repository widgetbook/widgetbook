import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook/widgetbook.dart';

part 'preview_state.freezed.dart';

@freezed
class PreviewState with _$PreviewState {
  factory PreviewState({
    required WidgetbookUseCase? selectedUseCase,
  }) = _PreviewState;

  factory PreviewState.unselected() {
    return PreviewState(selectedUseCase: null);
  }

  PreviewState._();

  bool get isUseCaseSelected => selectedUseCase != null;
}

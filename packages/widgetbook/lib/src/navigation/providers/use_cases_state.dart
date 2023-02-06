import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook/widgetbook.dart';

part 'use_cases_state.freezed.dart';

@freezed
class UseCasesState with _$UseCasesState {
  factory UseCasesState({
    @Default(<String, WidgetbookUseCase>{})
        Map<String, WidgetbookUseCase> useCases,
    String? selectedUseCasePath,
    WidgetbookUseCase? selectedUseCase,
  }) = _UseCasesState;
}

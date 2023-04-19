import 'package:flutter/material.dart';
import 'package:widgetbook/src/repositories/selected_use_case_repository.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

class UseCasesProvider extends ValueNotifier<UseCasesState> {
  UseCasesProvider({
    required this.selectedStoryRepository,
    UseCasesState? state,
  }) : super(state ?? UseCasesState());

  final SelectedUseCaseRepository selectedStoryRepository;

  void selectUseCaseByPath(String path) {
    final useCase = value.useCases[path];
    if (useCase != null) {
      value = value.copyWith(
        selectedUseCasePath: path,
        selectedUseCase: value.useCases[path],
      );
      selectedStoryRepository.setItem(
        WidgetbookUseCaseData(
          path: path,
          builder: useCase.builder,
        ),
      );
    }
  }

  void loadFromDirectories(List<MultiChildNavigationNodeData> directories) {
    final useCases = _getUseCases(directories);
    value = value.copyWith(
      useCases: useCases,
      selectedUseCase: value.selectedUseCasePath != null
          ? useCases[value.selectedUseCasePath]
          : null,
    );
  }

  Map<String, WidgetbookUseCase> _getUseCases(
    List<NavigationNodeDataInterface> directories, {
    List<String> currentPathSegments = const [],
  }) {
    final useCases = <String, WidgetbookUseCase>{};
    for (final directory in directories) {
      final pathSegments = [...currentPathSegments, directory.name];
      final children = directory.children;
      if (children is List<LeafNavigationNodeData>) {
        for (final child in children) {
          if (child is WidgetbookUseCase) {
            final path = [...pathSegments, child.name]
                .join('/')
                .replaceAll(' ', '-')
                .toLowerCase();

            useCases.addAll({
              path: child,
            });
          }
        }
      } else {
        useCases.addAll(
          _getUseCases(children, currentPathSegments: pathSegments),
        );
      }
    }
    return useCases;
  }
}

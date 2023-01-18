import 'package:widgetbook/src/repositories/selected_use_case_repository.dart';
import 'package:widgetbook/src/state_change_notifier.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

class UseCasesProvider extends StateChangeNotifier<UseCasesState> {
  UseCasesProvider({
    UseCasesState? state,
    required this.selectedStoryRepository,
  }) : super(state: state ?? UseCasesState());

  final SelectedUseCaseRepository selectedStoryRepository;

  void selectUseCaseByPath(String path) {
    final useCase = state.useCases[path];
    if (useCase != null) {
      state = state.copyWith(
        selectedUseCasePath: path,
        selectedUseCase: state.useCases[path],
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
    state = state.copyWith(
      useCases: useCases,
      selectedUseCase: state.selectedUseCasePath != null
          ? useCases[state.selectedUseCasePath]
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

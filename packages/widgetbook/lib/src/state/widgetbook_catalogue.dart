import 'package:widgetbook/src/navigation/models/models.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

class WidgetbookCatalogue {
  WidgetbookCatalogue._(
    Map<String, WidgetbookUseCase> useCases,
  ) : _useCases = useCases;

  factory WidgetbookCatalogue.fromDirectories(
    List<NavigationNodeDataInterface> directories,
  ) {
    final useCases = _getUseCases(directories);
    return WidgetbookCatalogue._(useCases);
  }

  final Map<String, WidgetbookUseCase> _useCases;

  WidgetbookUseCase? get(String path) => _useCases[path];

  static Map<String, WidgetbookUseCase> _getUseCases(
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
          _getUseCases(
            children,
            currentPathSegments: pathSegments,
          ),
        );
      }
    }
    return useCases;
  }
}

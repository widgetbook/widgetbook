import 'package:meta/meta.dart';

import '../navigation/navigation.dart';

@internal
class WidgetbookCatalog {
  WidgetbookCatalog._(
    Map<String, WidgetbookUseCase> useCases,
  ) : _useCases = useCases;

  factory WidgetbookCatalog.fromDirectories(
    List<NavigationNodeDataInterface> directories,
  ) {
    final useCases = _getUseCases(directories);
    return WidgetbookCatalog._(useCases);
  }

  final Map<String, WidgetbookUseCase> _useCases;

  bool hasPath(String path) => _useCases.containsKey(path);

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

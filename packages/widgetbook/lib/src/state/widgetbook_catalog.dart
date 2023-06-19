import 'package:meta/meta.dart';

import '../navigation/navigation.dart';

@internal
class WidgetbookCatalog {
  WidgetbookCatalog._(
    Map<String, WidgetbookUseCase> useCases,
  ) : _useCases = useCases;

  factory WidgetbookCatalog.fromDirectories(
    List<NavigationEntity> directories,
  ) {
    final useCases = _getUseCases(directories);
    return WidgetbookCatalog._(useCases);
  }

  final Map<String, WidgetbookUseCase> _useCases;

  WidgetbookUseCase? get(String path) => _useCases[path];

  static Map<String, WidgetbookUseCase> _getUseCases(
    List<NavigationEntity> directories,
  ) {
    final useCases = <String, WidgetbookUseCase>{};

    for (final directory in directories) {
      final children = directory.children ?? [];

      if (children is List<WidgetbookUseCase>) {
        for (final child in children) {
          useCases.addAll({
            child.path: child,
          });
        }
      } else {
        useCases.addAll(
          _getUseCases(children),
        );
      }
    }

    return useCases;
  }
}

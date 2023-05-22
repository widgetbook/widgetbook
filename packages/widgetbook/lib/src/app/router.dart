import 'package:go_router/go_router.dart';

import '../addons/addons.dart';
import '../state/state.dart';
import 'widgetbook_shell.dart';
import 'workbench.dart';

GoRouter createRouter({
  String? initialLocation = '/',
  required List<WidgetbookAddOn> addons,
  required WidgetbookCatalog catalog,
  required AppBuilder appBuilder,
}) {
  return GoRouter(
    initialLocation: initialLocation,
    routes: [
      ShellRoute(
        builder: (_, state, child) {
          final isPreview = state.queryParams.containsKey('preview');

          return WidgetbookScope(
            state: WidgetbookState(
              path: state.queryParams['path'] ?? '',
              previewMode: isPreview,
              queryParams: {...state.queryParams}, // Copy from UnmodifiableMap
              addons: addons,
              appBuilder: appBuilder,
              catalog: catalog,
            ),
            child: isPreview
                ? child
                : WidgetbookShell(
                    child: child,
                  ),
          );
        },
        routes: [
          GoRoute(
            name: '/',
            path: '/',
            builder: (_, __) => const Workbench(),
          ),
        ],
      )
    ],
  );
}

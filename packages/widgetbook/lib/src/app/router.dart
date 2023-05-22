import 'package:go_router/go_router.dart';

import '../addons/addons.dart';
import '../state/state.dart';
import 'widgetbook_shell.dart';
import 'workbench.dart';

extension QueryParamExtension on Map<String, String> {
  bool getBool(String name) {
    final value = this[name];
    if (value == null) {
      return false;
    }

    return value == 'true';
  }
}

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
          // If `preview` does not exist, and any of the deprecated query params
          // `disable-navigation` or `disable-properties` exist with `true`,
          // then preview mode will be enabled.
          final isPreview = state.queryParams.containsKey('preview') ||
              state.queryParams.getBool('disable-navigation') ||
              state.queryParams.getBool('disable-properties');

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

import 'package:go_router/go_router.dart';

import '../state/state.dart';
import 'widgetbook_shell.dart';
import 'workbench.dart';

GoRouter createRouter({
  String? initialLocation = '/',
  required WidgetbookState initialState,
}) {
  return GoRouter(
    initialLocation: initialLocation,
    routes: [
      ShellRoute(
        builder: (_, state, child) {
          final isPreview = state.queryParams.containsKey('preview');

          return WidgetbookScope(
            state: initialState.copyWithQueryParams(
              state.queryParams,
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

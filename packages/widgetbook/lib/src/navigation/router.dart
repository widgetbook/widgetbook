import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widgetbook/src/navigation/navigation.dart';
import 'package:widgetbook/src/widgetbook_page.dart';

T? parseRouterData<T>({
  required String name,
  required Map<String, dynamic> routerData,
  required Map<String, T> mappedData,
}) {
  final value = routerData[name] as String?;
  T? selectedValue;

  if (value != null) {
    if (mappedData.containsKey(value)) {
      selectedValue = mappedData[value];
    }
  }
  return selectedValue;
}

extension GoRouterExtension on BuildContext {
  void goTo({
    required Map<String, String> queryParams,
  }) {
    final goRouter = GoRouter.of(this);
    final uri = Uri.parse(goRouter.location);
    final queryParameters = Map<String, String>.from(uri.queryParameters);
    for (final pair in queryParams.entries) {
      queryParameters[pair.key] = pair.value;
    }

    goNamed('/', queryParams: queryParameters);
  }
}

bool _parseBoolQueryParameter({
  required String? value,
  bool defaultValue = false,
}) {
  if (value == null) {
    return defaultValue;
  }

  return value == 'true';
}

GoRouter createRouter({
  required UseCasesProvider useCasesProvider,
  // Used for testing
  String? initialLocation,
}) {
  final router = GoRouter(
    redirect: (context, routerState) {
      final path = routerState.queryParams['path'];

      if (path != null) {
        useCasesProvider.selectUseCaseByPath(path);
      }
      return null;
    },
    initialLocation: initialLocation,
    debugLogDiagnostics: true,
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          final disableNavigation = _parseBoolQueryParameter(
            value: state.queryParams['disable-navigation'],
          );
          return ColoredBox(
            color: Theme.of(context).colorScheme.surface,
            child: Row(
              children: [
                if (!disableNavigation)
                  NavigationPanelWrapper(
                    initialPath: state.location,
                  ),
                Expanded(child: child),
              ],
            ),
          );
        },
        routes: [
          GoRoute(
            name: '/',
            path: '/',
            pageBuilder: (context, state) {
              final disableProperties = _parseBoolQueryParameter(
                value: state.queryParams['disable-properties'],
              );

              return NoTransitionPage<void>(
                child: WidgetbookPage(
                  disableProperties: disableProperties,
                  routerData: state.queryParams,
                ),
              );
            },
          ),
        ],
      )
    ],
  );

  return router;
}

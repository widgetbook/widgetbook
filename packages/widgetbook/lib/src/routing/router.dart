import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widgetbook/src/navigation/navigation.dart';
import 'package:widgetbook/src/routing/widgetbook_panel.dart';
import 'package:widgetbook/src/widgetbook_page.dart';

T? parseQueryParameters<T>({
  required String name,
  required Map<String, dynamic> queryParameters,
  required Map<String, T> mappedData,
}) {
  final value = queryParameters[name] as String?;
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

Set<WidgetbookPanel> _getPanelsFromQueryParams(
  Map<String, String> queryParams,
) {
  // `panels` query parameter has higher precednce than the deprecated
  // `disable-navigation` and `disable-properties` query parameters
  if (queryParams.containsKey('panels')) {
    return _parsePanelsQueryParam(queryParams['panels']);
  }

  // Deprecated
  final disableNavigation = _parseBoolQueryParameter(
    value: queryParams['disable-navigation'],
  );

  // Deprecated
  final disableProperties = _parseBoolQueryParameter(
    value: queryParams['disable-properties'],
  );

  return {
    if (!disableNavigation) ...{
      WidgetbookPanel.navigation,
    },
    if (!disableProperties) ...{
      WidgetbookPanel.addons,
      WidgetbookPanel.knobs,
    }
  };
}

Set<WidgetbookPanel> _parsePanelsQueryParam(
  String? value,
) {
  if (value == null || value.isEmpty) {
    return {};
  }

  return value
      .replaceAll(RegExp('[{}]'), '')
      .split(',')
      .map((name) => WidgetbookPanel.values.byName(name))
      .toSet();
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
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          final panels = _getPanelsFromQueryParams(state.queryParams);

          return ColoredBox(
            color: Theme.of(context).colorScheme.surface,
            child: Row(
              children: [
                if (panels.contains(WidgetbookPanel.navigation))
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
              final panels = _getPanelsFromQueryParams(state.queryParams);

              return NoTransitionPage<void>(
                child: WidgetbookPage(
                  activePanels: panels,
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

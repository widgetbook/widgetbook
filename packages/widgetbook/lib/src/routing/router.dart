import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/routing/widgetbook_panel.dart';
import 'package:widgetbook/src/widgetbook_shell.dart';
import 'package:widgetbook/src/workbench/workbench.dart';
import 'package:widgetbook/widgetbook.dart';

extension GoRouterExtension on GoRouter {
  void updateQueryParam(String name, String value) {
    final uri = Uri.parse(location);

    goNamed(
      '/',
      queryParams: {
        ...uri.queryParameters,
        name: value,
      },
    );
  }
}

Set<WidgetbookPanel> _parsePanelsQueryParam(
  String? value,
) {
  if (value == null) {
    return WidgetbookPanel.values.toSet();
  }

  if (value.isEmpty || value == '{}') {
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
  required WidgetbookCatalogue catalogue,
  // Used for testing
  String? initialLocation,
}) {
  final router = GoRouter(
    redirect: (context, state) {
      // Redirect deprecated `disable-navigation` and `disable-properties`
      // query params to their equivalent `panels` query param.
      if (state.queryParams.containsKey('disable-navigation') ||
          state.queryParams.containsKey('disable-properties')) {
        final disableNavigation = _parseBoolQueryParameter(
          value: state.queryParams['disable-navigation'],
        );

        final disableProperties = _parseBoolQueryParameter(
          value: state.queryParams['disable-properties'],
        );

        final panels = {
          if (!disableNavigation) ...{
            WidgetbookPanel.navigation,
          },
          if (!disableProperties) ...{
            WidgetbookPanel.addons,
            WidgetbookPanel.knobs,
          }
        };

        return '/?panels={${panels.map((x) => x.name).join(",")}}';
      }
    },
    initialLocation: initialLocation,
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          final panels = _parsePanelsQueryParam(state.queryParams['panels']);

          return WidgetbookShell(
            panels: panels,
            initialLocation: state.location,
            child: child,
          );
        },
        routes: [
          GoRoute(
            name: '/',
            path: '/',
            pageBuilder: (_, state) {
              final path = state.queryParams['path'];

              return NoTransitionPage<void>(
                child: Workbench(
                  useCase: catalogue.get(path ?? ''),
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

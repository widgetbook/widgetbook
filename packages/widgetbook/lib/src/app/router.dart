import 'package:go_router/go_router.dart';

import '../addons/addons.dart';
import '../state/state.dart';
import 'widgetbook_shell.dart';
import 'workbench.dart';

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
  String? initialLocation = '/',
  required List<WidgetbookAddOn> addons,
  required WidgetbookCatalog catalog,
  required AppBuilder appBuilder,
}) {
  return GoRouter(
    initialLocation: initialLocation,
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

      return null;
    },
    routes: [
      ShellRoute(
        builder: (_, state, child) => WidgetbookScope(
          state: WidgetbookState(
            path: state.queryParams['path'] ?? '',
            panels: state.queryParams['panels'] == null
                ? WidgetbookPanel.values.toSet()
                : WidgetbookPanelParser.parse(state.queryParams['panels']!),
            queryParams: {...state.queryParams}, // Copy from UnmodifiableMap
            addons: addons,
            appBuilder: appBuilder,
            catalog: catalog,
          ),
          child: WidgetbookShell(
            child: child,
          ),
        ),
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

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/addon_provider.dart';
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

void navigate(BuildContext context) {
  final addons = context.read<AddOnProvider>().value;
  final queryParameters = <String, String>{};
  for (final addon in addons) {
    queryParameters.addAll(addon.getQueryParameter(context));
  }

  final useCasePath =
      context.read<UseCasesProvider>().state.selectedUseCasePath;
  if (useCasePath != null) {
    queryParameters.putIfAbsent('path', () => useCasePath);
  }

  context.goNamed(
    '/',
    queryParams: queryParameters,
  );
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
}) {
  final router = GoRouter(
    redirect: (context, routerState) {
      final path = routerState.queryParams['path'];

      if (path != null) {
        useCasesProvider.selectUseCaseByPath(path);
      }
      return null;
    },
    routes: [
      GoRoute(
        name: '/',
        path: '/',
        pageBuilder: (context, state) {
          final disableNavigation = _parseBoolQueryParameter(
            value: state.queryParams['disable-navigation'],
          );
          final disableProperties = _parseBoolQueryParameter(
            value: state.queryParams['disable-properties'],
          );

          return NoTransitionPage<void>(
            child: WidgetbookPage(
              disableNavigation: disableNavigation,
              disableProperties: disableProperties,
              routerData: state.queryParams,
            ),
          );
        },
      ),
    ],
  );

  return router;
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/addon_provider.dart';
import 'package:widgetbook/src/navigation/preview_provider.dart';
import 'package:widgetbook/src/widgetbook_page.dart';
import 'package:widgetbook/src/workbench/workbench_provider.dart';

void navigate(BuildContext context) {
  final addons = context.read<AddOnProvider>().value;
  final queryParameters = {
    for (final addon in addons) addon.name: addon.getQueryParameter(context)
  };

  final usecase = context.read<PreviewProvider>().state.selectedUseCase;
  if (usecase != null) {
    queryParameters.putIfAbsent('path', () => usecase.path);
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

GoRouter createRouter<CustomTheme>({
  required WorkbenchProvider<CustomTheme> workbenchProvider,
  required PreviewProvider previewProvider,
}) {
  final router = GoRouter(
    redirect: (routerState) {
      final path = routerState.queryParams['path'];

      previewProvider.selectUseCaseByPath(path);
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
            child: WidgetbookPage<CustomTheme>(
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

import 'package:go_router/go_router.dart';
import 'package:widgetbook/src/extensions/enum_extension.dart';
import 'package:widgetbook/src/navigation/preview_provider.dart';
import 'package:widgetbook/src/widgetbook_page.dart';
import 'package:widgetbook/src/workbench/workbench_provider.dart';

void refreshRoute<CustomTheme>(
  GoRouter router, {
  required WorkbenchProvider<CustomTheme> workbenchProvider,
  required PreviewProvider previewProvider,
}) {
  final previewState = previewProvider.state;
  final workbenchState = workbenchProvider.state;

  final queryParameters = <String, String>{};

  if (workbenchState.hasSelectedTheme) {
    queryParameters.putIfAbsent(
      'theme',
      () => workbenchState.theme!.name,
    );
  }

  if (workbenchState.hasSelectedLocale) {
    queryParameters.putIfAbsent(
      'locale',
      () => workbenchState.locale!.languageCode,
    );
  }

  if (workbenchState.hasSelectedDevice) {
    queryParameters.putIfAbsent(
      'device',
      () => workbenchState.device!.name,
    );
  }

  if (workbenchState.hasSelectedTextScaleFactor) {
    queryParameters.putIfAbsent(
      'text-scale-factor',
      () => workbenchState.textScaleFactor!.toStringAsFixed(1),
    );
  }

  queryParameters
    ..putIfAbsent(
      'orientation',
      () => workbenchState.orientation.toShortString(),
    )
    ..putIfAbsent(
      'frame',
      () => workbenchState.frame.name,
    );

  if (previewState.isUseCaseSelected) {
    queryParameters.putIfAbsent(
      'path',
      () => previewState.selectedUseCase!.path,
    );
  }

  router.goNamed('/', queryParams: queryParameters);
}

GoRouter createRouter<CustomTheme>({
  required WorkbenchProvider<CustomTheme> workbenchProvider,
  required PreviewProvider previewProvider,
}) {
  final router = GoRouter(
    redirect: (routerState) {
      final theme = routerState.queryParams['theme'];
      final locale = routerState.queryParams['locale'];
      final device = routerState.queryParams['device'];
      final textScaleFactor = routerState.queryParams['text-scale-factor'];
      final orientation = routerState.queryParams['orientation'];
      final frame = routerState.queryParams['frame'];
      final path = routerState.queryParams['path'];
      workbenchProvider
        ..setThemeByName(theme)
        ..setLocaleByName(locale)
        ..setDeviceByName(device)
        ..setTextScaleFactorByName(textScaleFactor)
        ..setOrientationByName(orientation)
        ..setFrameByName(frame);
      previewProvider.selectUseCaseByPath(path);
      return null;
    },
    routes: [
      GoRoute(
        name: '/',
        path: '/',
        pageBuilder: (context, state) {
          return NoTransitionPage<void>(child: WidgetbookPage<CustomTheme>());
        },
      ),
    ],
  );

  previewProvider.addListener(() {
    refreshRoute(
      router,
      workbenchProvider: workbenchProvider,
      previewProvider: previewProvider,
    );
  });

  workbenchProvider.addListener(() {
    refreshRoute(
      router,
      workbenchProvider: workbenchProvider,
      previewProvider: previewProvider,
    );
  });

  return router;
}

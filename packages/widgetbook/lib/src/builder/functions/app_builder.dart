import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widgetbook/src/builder/builder.dart';
import 'package:widgetbook/src/builder/functions/custom_materialApp.dart';
import 'package:widgetbook/widgetbook.dart';

const AppBuilderFunction defaultAppBuilder = _defaultAppBuilderMethod;

GoRouter getRouter(Widget child) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => child,
      ),
    ],
  );
}

Widget _defaultAppBuilderMethod(BuildContext context, Widget child) {
  final _router = getRouter(child);
  return WidgetsApp.router(
    color: Colors.transparent,
    builder: (context, childWidget) {
      return childWidget ?? child;
    },
    debugShowCheckedModeBanner: false,
    routeInformationParser: _router.routeInformationParser,
    routerDelegate: _router.routerDelegate,
  );
}

AppBuilderFunction get materialAppBuilder =>
    (BuildContext context, Widget child) {
      final _router = getRouter(child);
      final frameBuilder = context.frameBuilder;
      return frameBuilder(
        context,
        CustomMaterialTheme(
          routerDelegate: _router.routerDelegate,
          routeInformationParser: _router.routeInformationParser,
          locale: context.localization.activeLocale,
          supportedLocales: context.localization.supportedLocales,
          localizationsDelegates: context.localization.localizationsDelegates,
          debugShowCheckedModeBanner: false,
        ),
      );
    };

AppBuilderFunction get cupertinoAppBuilder =>
    (BuildContext context, Widget child) {
      final _router = getRouter(child);
      return CupertinoApp.router(
        debugShowCheckedModeBanner: false,
        routerDelegate: _router.routerDelegate,
        routeInformationParser: _router.routeInformationParser,
      );
    };

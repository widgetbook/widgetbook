import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
    routeInformationParser: _router.routeInformationParser,
    routerDelegate: _router.routerDelegate,
  );
}

AppBuilderFunction get materialAppBuilder =>
    (BuildContext context, Widget child) {
      return MaterialApp(
        theme: context.theme,
        locale: context.localization.activeLocale,
        supportedLocales: context.localization.supportedLocales,
        localizationsDelegates: context.localization.localizationsDelegates,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: context.textScale,
            ),
            child: child,
          ),
        ),
      );
    };

AppBuilderFunction get cupertinoAppBuilder =>
    (BuildContext context, Widget child) {
      final _router = getRouter(child);
      return CupertinoApp.router(
        routerDelegate: _router.routerDelegate,
        routeInformationParser: _router.routeInformationParser,
      );
    };

typedef AppBuilderFunction = Widget Function(
  BuildContext context,
  Widget child,
);

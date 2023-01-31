import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widgetbook/src/builder/builder.dart';
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

// TODO make this work
Widget _defaultAppBuilderMethod(BuildContext context, Widget child) {
  final router = getRouter(child);
  return WidgetsApp.router(
    color: Colors.transparent,
    builder: (context, childWidget) {
      return childWidget ?? child;
    },
    debugShowCheckedModeBanner: false,
    routeInformationParser: router.routeInformationParser,
    routerDelegate: router.routerDelegate,
  );
}

AppBuilderFunction get materialAppBuilder =>
    (BuildContext context, Widget child) {
      final builder = Builder(
        builder: (context) {
          return MaterialApp(
            theme: context.materialTheme,
            locale: context.localization?.activeLocale,
            supportedLocales: context.localization?.supportedLocales ??
                const <Locale>[
                  Locale('en', 'US'),
                ],
            localizationsDelegates:
                context.localization?.localizationsDelegates,
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
        },
      );
      final frameBuilder = context.frameBuilder;
      return frameBuilder == null
          ? builder
          : frameBuilder(
              context,
              builder,
            );
    };

// TODO make this work
AppBuilderFunction get cupertinoAppBuilder =>
    (BuildContext context, Widget child) {
      final router = getRouter(child);
      return CupertinoApp.router(
        debugShowCheckedModeBanner: false,
        routerDelegate: router.routerDelegate,
        routeInformationParser: router.routeInformationParser,
      );
    };

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const AppBuilderFunction defaultAppBuilder = _defaultAppBuilderMethod;

Widget _defaultAppBuilderMethod(BuildContext context, Widget child) {
  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => child,
      ),
    ],
  );
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
        home: child,
      );
    };

AppBuilderFunction get cupertinoAppBuilder =>
    (BuildContext context, Widget child) {
      return CupertinoApp(
        home: child,
      );
    };

typedef AppBuilderFunction = Widget Function(
  BuildContext context,
  Widget child,
);

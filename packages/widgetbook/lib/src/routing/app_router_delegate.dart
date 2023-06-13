import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../state/state.dart';
import '../workbench/workbench.dart';
import 'app_route_config.dart';
import 'widgetbook_shell.dart';

@internal
class AppRouterDelegate extends RouterDelegate<AppRouteConfig>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRouteConfig> {
  AppRouterDelegate({
    this.initialRoute = '/',
    required this.initialState,
  })  : _navigatorKey = GlobalKey<NavigatorState>(),
        _configuration = AppRouteConfig(
          location: initialRoute,
        );

  final String initialRoute;
  final WidgetbookState initialState;
  final GlobalKey<NavigatorState> _navigatorKey;
  AppRouteConfig _configuration;

  @override
  AppRouteConfig? get currentConfiguration => _configuration;

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  Future<void> setNewRoutePath(AppRouteConfig configuration) async {
    _configuration = configuration;
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: (route, result) => route.didPop(result),
      pages: [
        MaterialPage(
          child: WidgetbookScope(
            state: initialState.copyFromRouteConfig(_configuration),
            child: _configuration.previewMode
                ? const Workbench()
                : const WidgetbookShell(
                    child: Workbench(),
                  ),
          ),
        ),
      ],
    );
  }
}

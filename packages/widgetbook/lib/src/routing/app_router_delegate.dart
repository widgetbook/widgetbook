import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../layout/responsive_layout.dart';
import '../state/state.dart';
import '../workbench/workbench.dart';
import 'app_route_config.dart';

@internal
class AppRouterDelegate extends RouterDelegate<AppRouteConfig>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRouteConfig> {
  AppRouterDelegate({
    required this.uri,
    required this.state,
  }) : _navigatorKey = GlobalKey<NavigatorState>(),
       _configuration = AppRouteConfig(
         uri: uri,
       );

  final Uri uri;
  final WidgetbookState state;
  final GlobalKey<NavigatorState> _navigatorKey;
  AppRouteConfig _configuration;

  @override
  AppRouteConfig? get currentConfiguration => _configuration;

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  Future<void> setNewRoutePath(AppRouteConfig configuration) async {
    _configuration = configuration;
    state.updateFromRouteConfig(configuration);
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onDidRemovePage: (_) => {},
      pages: [
        MaterialPage(
          child:
              _configuration.previewMode
                  ? const Workbench()
                  : ResponsiveLayout(
                    key: ValueKey(_configuration),
                    child: const Workbench(),
                  ),
        ),
      ],
    );
  }
}

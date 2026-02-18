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
    required Uri uri,
    required this.state,
  }) {
    state.updateFromRouteConfig(
      AppRouteConfig(uri: uri),
    );
    this.state.addListener(notifyListeners);
  }

  final WidgetbookState state;

  @override
  AppRouteConfig get currentConfiguration => state.toAppRouteConfig();

  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Future<void> setNewRoutePath(AppRouteConfig configuration) async {
    state.updateFromRouteConfig(configuration);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onDidRemovePage: (_) => {},
      pages: [
        MaterialPage(
          child: currentConfiguration.previewMode
              ? const Workbench()
              : const ResponsiveLayout(
                  child: Workbench(),
                ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    state.removeListener(notifyListeners);
    super.dispose();
  }
}

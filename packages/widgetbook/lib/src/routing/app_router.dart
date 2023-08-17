import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import '../state/state.dart';
import 'app_route_config.dart';
import 'app_route_parser.dart';
import 'app_router_delegate.dart';

@internal
class AppRouter extends RouterConfig<AppRouteConfig> {
  AppRouter({
    String initialRoute = '/',
    required WidgetbookState state,
  }) : super(
          routeInformationParser: AppRouteParser(),
          routeInformationProvider: PlatformRouteInformationProvider(
            initialRouteInformation: RouteInformation(
              // Not backwards compatible with Flutter < 3.13.0
              // ignore: deprecated_member_use
              location: initialRoute,
            ),
          ),
          routerDelegate: AppRouterDelegate(
            initialRoute: initialRoute,
            state: state,
          ),
        );
}

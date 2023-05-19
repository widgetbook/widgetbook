import 'package:flutter/widgets.dart';

import '../state/state.dart';
import 'app_route_config.dart';
import 'app_route_parser.dart';
import 'app_router_delegate.dart';

class AppRouter extends RouterConfig<AppRouteConfig> {
  AppRouter({
    String initialRoute = '/',
    required WidgetbookState initialState,
  }) : super(
          routeInformationParser: AppRouteParser(),
          routeInformationProvider: PlatformRouteInformationProvider(
            initialRouteInformation: RouteInformation(
              location: initialRoute,
            ),
          ),
          routerDelegate: AppRouterDelegate(
            initialRoute: initialRoute,
            initialState: initialState,
          ),
        );
}

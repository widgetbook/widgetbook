import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import '../state/state.dart';
import 'app_route_config.dart';
import 'app_route_parser.dart';
import 'app_router_delegate.dart';

@internal
class AppRouter extends RouterConfig<AppRouteConfig> {
  AppRouter({
    required Uri uri,
    required WidgetbookState state,
  }) : super(
         routeInformationParser: AppRouteParser(),
         routeInformationProvider: PlatformRouteInformationProvider(
           initialRouteInformation: RouteInformation(
             uri: uri,
           ),
         ),
         routerDelegate: AppRouterDelegate(
           uri: uri,
           state: state,
         ),
       );
}

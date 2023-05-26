import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'app_route_config.dart';

@internal
class AppRouteParser extends RouteInformationParser<AppRouteConfig> {
  @override
  Future<AppRouteConfig> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    return AppRouteConfig(
      location: routeInformation.location ?? '/',
    );
  }

  @override
  RouteInformation restoreRouteInformation(
    AppRouteConfig configuration,
  ) {
    return RouteInformation(
      location: configuration.location,
    );
  }
}

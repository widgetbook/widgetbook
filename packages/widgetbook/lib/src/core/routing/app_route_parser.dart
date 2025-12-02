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
      uri: routeInformation.uri,
    );
  }

  @override
  RouteInformation restoreRouteInformation(
    AppRouteConfig configuration,
  ) {
    return RouteInformation(
      uri: configuration.uri,
    );
  }
}

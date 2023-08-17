import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'app_route_config.dart';

@internal
class AppRouteParser extends RouteInformationParser<AppRouteConfig> {
  /// This allows a value of type T or T?
  /// to be treated as a value of type T?.
  ///
  /// We use this so that APIs that have become
  /// non-nullable can still be used with `!` and `?`
  /// to support older versions of the API as well.
  T? _ambiguate<T>(T? value) => value;

  @override
  Future<AppRouteConfig> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    // Not backwards compatible with Flutter < 3.13.0
    // ignore: deprecated_member_use
    final location = routeInformation.location;

    // We use [_ambiguate] to support older versions of Flutter,
    // since [RouteInformation.location] has changed to be non-nullable
    // in Flutter 3.13.0.
    final ambiguousLocation = _ambiguate(location);

    return AppRouteConfig(
      uri: Uri.parse(ambiguousLocation ?? '/'),
    );
  }

  @override
  RouteInformation restoreRouteInformation(
    AppRouteConfig configuration,
  ) {
    return RouteInformation(
      // Not backwards compatible with Flutter < 3.13.0
      // ignore: deprecated_member_use
      location: configuration.uri.toString(),
    );
  }
}

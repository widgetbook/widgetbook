import 'package:flutter/widgets.dart';
import 'package:widgetbook/src/routing/story_route_path.dart';

class StoryRouteInformationParser
    extends RouteInformationParser<StoryRoutePath> {
  final Function(String path) onRoute;

  StoryRouteInformationParser({
    required this.onRoute,
  });

  @override
  Future<StoryRoutePath> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    final uri = Uri.parse(routeInformation.location ?? '');
    onRoute(uri.path);
    return StoryRoutePath(path: uri.path);
  }

  @override
  RouteInformation restoreRouteInformation(StoryRoutePath configuration) {
    return RouteInformation(location: configuration.path);
  }
}

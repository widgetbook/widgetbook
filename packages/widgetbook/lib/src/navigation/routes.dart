import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// part 'routes.g.dart';

@TypedGoRoute<HomeRoute>(
  path: '/',
)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context) => Container();
}

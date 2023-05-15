import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import '../addons/addons.dart';
import '../navigation/navigation.dart';
import 'widgetbook_catalogue.dart';
import 'widgetbook_panel.dart';
import 'widgetbook_scope.dart';

typedef AppBuilder = Widget Function(BuildContext context, Widget child);

class WidgetbookState extends ChangeNotifier {
  WidgetbookState({
    required this.path,
    required this.panels,
    required this.queryParams,
    required this.addons,
    required this.catalogue,
    required this.appBuilder,
  });

  String path;
  final Set<WidgetbookPanel> panels;
  final Map<String, String> queryParams;
  final List<WidgetbookAddOn> addons;
  final WidgetbookCatalogue catalogue;
  final AppBuilder appBuilder;

  WidgetbookUseCase? get useCase => catalogue.get(path);

  static WidgetbookState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<WidgetbookScope>()!
        .notifier!;
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
    syncRouteInformation();
  }

  /// Syncs this with the router's location using [SystemNavigator].
  @internal
  void syncRouteInformation() {
    final uri = Uri(
      path: '/',
      queryParameters: {
        'path': path,
        ...queryParams,
      },
    );

    SystemNavigator.routeInformationUpdated(
      location: uri.toString(),
    );
  }

  void updateQueryParam(String name, String value) {
    queryParams[name] = value;
    notifyListeners();
  }

  void updatePath(String newPath) {
    path = newPath;
    notifyListeners();
  }
}

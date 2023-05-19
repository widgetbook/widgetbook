import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import '../addons/addons.dart';
import '../knobs/knob.dart';
import '../models/models.dart';
import 'widgetbook_catalog.dart';
import 'widgetbook_panel.dart';
import 'widgetbook_scope.dart';

typedef AppBuilder = Widget Function(BuildContext context, Widget child);

class WidgetbookState extends ChangeNotifier {
  WidgetbookState({
    required this.path,
    required this.panels,
    required this.queryParams,
    required this.addons,
    required this.catalog,
    required this.appBuilder,
  }) : this.knobs = {};

  String path;
  final Map<String, Knob> knobs;
  final Set<WidgetbookPanel> panels;
  final Map<String, String> queryParams;
  final List<WidgetbookAddOn> addons;
  final WidgetbookCatalog catalog;
  final AppBuilder appBuilder;

  WidgetbookUseCase? get useCase => catalog.get(path);

  Uri get uri => Uri(
        path: '/',
        queryParameters: {
          'path': path,
          ...queryParams,
        },
      );

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
    knobs.clear(); // Reset Knobs
    queryParams.remove('knobs');
    notifyListeners();
  }

  void updateKnobValue<T>(String label, T value) {
    knobs[label]!.value = value;
    notifyListeners();
  }

  void updateKnobNullability(String label, bool isNull) {
    knobs[label]!.isNull = isNull;
    notifyListeners();
  }

  T? registerKnob<T>(Knob<T> knob) {
    final cachedKnob = knobs.putIfAbsent(
      knob.label,
      () {
        Future.microtask(notifyListeners);
        return knob;
      },
    );

    // Return `null` even if the knob has value, but it was marked as null
    // using [updateKnobNullability].
    return cachedKnob.isNull ? null : (cachedKnob.value as T);
  }
}

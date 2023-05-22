import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import '../addons/addons.dart';
import '../integrations/widgetbook_integration.dart';
import '../knobs/knob.dart';
import '../models/models.dart';
import 'widgetbook_catalog.dart';
import 'widgetbook_scope.dart';

typedef AppBuilder = Widget Function(BuildContext context, Widget child);

class WidgetbookState extends ChangeNotifier {
  WidgetbookState({
    this.path = '',
    this.previewMode = false,
    this.queryParams = const {},
    required this.catalog,
    required this.appBuilder,
    this.addons,
    this.integrations,
  }) : this.knobs = {};

  String path;
  final Map<String, Knob> knobs;
  final bool previewMode;
  final Map<String, String> queryParams;
  final WidgetbookCatalog catalog;
  final AppBuilder appBuilder;
  final List<WidgetbookAddOn>? addons;
  final List<WidgetbookIntegration>? integrations;

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

    // Do not sync route in preview mode, since the widget state is already
    // controlled by using the URL.
    if (!previewMode) {
      syncRouteInformation();
    }

    integrations?.forEach(
      (integration) => integration.onChange(this),
    );
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

  WidgetbookState copyWithQueryParams(Map<String, String> params) {
    return WidgetbookState(
      path: params['path'] ?? '',
      previewMode: params.containsKey('preview'),
      queryParams: {...params}, // Copy from UnmodifiableMap
      catalog: catalog,
      appBuilder: appBuilder,
      addons: addons,
      integrations: integrations,
    );
  }
}

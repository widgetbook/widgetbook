import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../addons/addons.dart';
import '../fields/fields.dart';
import '../integrations/widgetbook_integration.dart';
import '../knobs/knob.dart';
import '../models/models.dart';
import '../routing/routing.dart';
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

  /// A [Uri] representation of the current state.
  Uri get uri => Uri(
        path: '/',
        queryParameters: {
          'path': path,
          ...queryParams,
        },
      );

  /// Gets the current state using [context].
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
  void syncRouteInformation() {
    SystemNavigator.routeInformationUpdated(
      location: uri.toString(),
    );
  }

  /// Update the [name] query parameter with the given [value].
  void updateQueryParam(String name, String value) {
    queryParams[name] = value;
    notifyListeners();
  }

  /// Update the [path], causing a new [useCase] to bet returned.
  /// Resets the [knobs] during the update.
  void updatePath(String newPath) {
    path = newPath;
    knobs.clear(); // Reset Knobs
    queryParams.remove('knobs');
    notifyListeners();
  }

  /// Updates [Knob.value] using the [label] to find the [Knob].
  void updateKnobValue<T>(String label, T value) {
    knobs[label]!.value = value;
    notifyListeners();
  }

  /// Updates [Knob.isNull] using the [label] to find the [Knob].
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
    if (cachedKnob.isNull) return null;

    final knobsQueryGroup = FieldCodec.decodeQueryGroup(queryParams['knobs']);

    return knob.valueFromQueryGroup(knobsQueryGroup);
  }

  /// Creates a copy of the current state using [AppRouteConfig] to update
  /// the [path], [previewMode] and [queryParams] fields. Since these fields
  /// can be manipulated from the router's query parameters, as opposed to the
  /// rest of fields that stay unchanged during runtime.
  WidgetbookState copyFromRouteConfig(AppRouteConfig configuration) {
    return WidgetbookState(
      path: configuration.path,
      previewMode: configuration.previewMode,
      queryParams: {
        // Copy from UnmodifiableMap
        ...configuration.queryParameters
      },
      catalog: catalog,
      appBuilder: appBuilder,
      addons: addons,
      integrations: integrations,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import '../addons/addons.dart';
import '../fields/fields.dart';
import '../integrations/widgetbook_integration.dart';
import '../knobs/knob.dart';
import '../navigation/navigation.dart';
import '../routing/routing.dart';
import 'widgetbook_catalog.dart';
import 'widgetbook_scope.dart';

typedef AppBuilder = Widget Function(BuildContext context, Widget child);

class WidgetbookState extends ChangeNotifier {
  WidgetbookState({
    this.path,
    this.previewMode = false,
    this.queryParams = const {},
    required this.appBuilder,
    this.addons,
    this.integrations,
    required this.root,
  })  : this.knobs = {},
        this.catalog = WidgetbookCatalog.fromRoot(root);

  String? path;
  bool previewMode;
  Map<String, String> queryParams;

  final Map<String, Knob> knobs;
  final WidgetbookCatalog catalog;
  final AppBuilder appBuilder;
  final List<WidgetbookAddon>? addons;
  final List<WidgetbookIntegration>? integrations;
  final WidgetbookRoot root;

  List<WidgetbookNode> get directories => root.children!;

  WidgetbookUseCase? get useCase => path == null ? null : catalog.get(path!);

  /// A [Uri] representation of the current state.
  Uri get uri {
    final queryParameters = {
      ...queryParams,
      if (path != null) 'path': path,
    };

    return Uri(
      path: '/',
      queryParameters: queryParameters.isEmpty ? null : queryParameters,
    );
  }

  /// Gets the current state using [context].
  static WidgetbookState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<WidgetbookScope>()!
        .notifier!;
  }

  @internal
  @override
  void notifyListeners() {
    super.notifyListeners();

    // Do not sync route in preview mode, since the widget state is already
    // controlled by using the URL.
    if (!previewMode) {
      _syncRouteInformation();
    }

    integrations?.forEach(
      (integration) => integration.onChange(this),
    );
  }

  /// Syncs this with the router's location using [SystemNavigator].
  void _syncRouteInformation() {
    SystemNavigator.routeInformationUpdated(
      location: uri.toString(),
    );
  }

  /// Update the [name] query parameter with the given [value].
  @internal
  void updateQueryParam(String name, String value) {
    queryParams[name] = value;
    notifyListeners();
  }

  /// Update the [path], causing a new [useCase] to bet returned.
  /// Resets the [knobs] during the update.
  @internal
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
  @internal
  void updateKnobNullability(String label, bool isNull) {
    knobs[label]!.isNull = isNull;
    notifyListeners();
  }

  @internal
  T? registerKnob<T>(Knob<T> knob) {
    final cachedKnob = knobs.putIfAbsent(
      knob.label,
      () => knob,
    );

    // Return `null` even if the knob has value, but it was marked as null
    // using [updateKnobNullability].
    if (cachedKnob.isNull) return null;

    final knobsQueryGroup = FieldCodec.decodeQueryGroup(queryParams['knobs']);

    return knob.valueFromQueryGroup(knobsQueryGroup);
  }

  @internal
  void notifyKnobsReady() {
    notifyListeners();

    integrations?.forEach(
      (integration) => integration.onKnobsRegistered(this),
    );
  }

  /// Update the current state using [AppRouteConfig] to update
  /// the [path], [previewMode] and [queryParams] fields. Since these fields
  /// can be manipulated from the router's query parameters, as opposed to the
  /// rest of fields that stay unchanged during runtime.
  @internal
  void updateFromRouteConfig(AppRouteConfig routeConfig) {
    path = routeConfig.path;
    previewMode = routeConfig.previewMode;
    queryParams = {
      // Copy from UnmodifiableMap
      ...routeConfig.queryParameters
    }
      ..remove('path')
      ..remove('preview');

    notifyListeners();
  }
}

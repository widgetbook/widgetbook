import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import '../../next.dart';
import '../addons/addons.dart';
import '../fields/fields.dart';
import '../integrations/widgetbook_integration.dart';
import '../knobs/knobs.dart';
import '../navigation/navigation.dart';
import '../routing/routing.dart';
import '../utils.dart';
import 'default_app_builders.dart';
import 'default_home_page.dart';
import 'widgetbook_scope.dart';

typedef AppBuilder = Widget Function(BuildContext context, Widget child);

enum LayoutPanel {
  navigation,
  addons,
  knobs,
}

class WidgetbookState extends ChangeNotifier {
  WidgetbookState({
    this.path,
    this.query,
    this.previewMode = false,
    this.queryParams = const {},
    this.appBuilder = widgetsAppBuilder,
    this.addons,
    this.integrations,
    required this.root,
    this.home = const DefaultHomePage(),
    this.panels = null,
    this.customHeader,
  }) {
    this.knobs = KnobsRegistry(
      onLock: () {
        integrations?.forEach(
          (integration) => integration.onKnobsRegistered(this),
        );
      },
    );

    knobs.addListener(
      notifyListeners,
    );
  }

  String? path;
  String? query;
  bool previewMode;
  Map<String, String> queryParams;

  /// Determines which panels are shown.
  /// - If `null`, all panels are shown.
  /// - If empty, no panels are shown (similar to [previewMode]).
  /// - If [previewMode] is `true`, the [panels] are ignored.
  ///
  /// NOTE: this only works in desktop mode.
  Set<LayoutPanel>? panels;

  late final KnobsRegistry knobs;
  final AppBuilder appBuilder;
  final List<WidgetbookAddon>? addons;
  final List<WidgetbookIntegration>? integrations;
  final WidgetbookRoot root;
  final Widget home;

  /// An optional widget to display at the top of the navigation panel.
  /// This can be used for branding or additional information.
  final Widget? customHeader;

  List<WidgetbookNode> get directories => root.children!;

  WidgetbookUseCase? get useCase => path == null ? null : root.table[path!];

  /// Same as [addons] but without the ones that have no fields.
  @internal
  List<WidgetbookAddon>? get effectiveAddons {
    return addons?.where((addon) => addon.fields.isNotEmpty).toList();
  }

  /// A [Uri] representation of the current state.
  Uri get uri {
    final queryParameters = {
      if (path != null) 'path': path,
      if (query?.isNotEmpty ?? false) 'q': query,
      if (panels?.isNotEmpty ?? false)
        'panels': panels?.map((x) => x.name).join(','),
      ...queryParams,
    };

    return Uri(
      path: '/',
      queryParameters: queryParameters.isEmpty ? null : queryParameters,
    );
  }

  /// Gets the current state using [context], if any.
  /// If there is no state in scope, then this function will return null.
  static WidgetbookState? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<WidgetbookScope>()
        ?.notifier;
  }

  /// Gets the current state using [context].
  static WidgetbookState of(BuildContext context) {
    final state = WidgetbookState.maybeOf(context);
    assert(state != null, 'No Widgetbook found in the context.');
    return state!;
  }

  @internal
  @override
  void notifyListeners() {
    super.notifyListeners();

    // Do not sync route if the panels are not showing up,
    // since the widget state is already controlled by using the URL.
    if (canShowPanel(LayoutPanel.navigation) ||
        canShowPanel(LayoutPanel.addons) ||
        canShowPanel(LayoutPanel.knobs)) {
      _syncRouteInformation();
    }

    integrations?.forEach(
      (integration) => integration.onChange(this),
    );
  }

  bool canShowPanel(LayoutPanel panel) {
    if (previewMode) return false;
    if (panels == null) return true;
    return panels!.contains(panel);
  }

  /// Syncs this with the router's location using [SystemNavigator].
  void _syncRouteInformation() {
    SystemNavigator.routeInformationUpdated(
      uri: uri,
    );
  }

  /// Update the [name] query parameter with the given [value].
  @internal
  void updateQueryParam(String name, String value) {
    if (AppRouteConfig.reservedKeys.contains(name)) {
      throw ArgumentError(
        'The query parameter $name is reserved and cannot be updated.',
      );
    }

    queryParams[name] = value;
    notifyListeners();
  }

  /// Update the field within the query [group] with the given [value].
  void updateQueryField({
    required String group,
    required String field,
    required String value,
  }) {
    final groupMap = FieldCodec.decodeQueryGroup(queryParams[group]);

    final newGroupMap = Map<String, String>.from(groupMap)
      ..update(
        field,
        (_) => value,
        ifAbsent: () => value,
      );

    updateQueryParam(
      group,
      FieldCodec.encodeQueryGroup(newGroupMap),
    );
  }

  /// Update the [path], causing a new [useCase] to bet returned.
  /// Resets the [knobs] during the update.
  @internal
  void updatePath(String newPath) {
    path = newPath;

    // Reset Knobs
    knobs.clear();
    queryParams.remove('knobs');

    notifyListeners();
  }

  /// Updates the `q` query parameter with the given [value].
  @internal
  void updateQuery(String value) {
    query = value;
    notifyListeners();
  }

  /// Updates [Knob.value] using the [label] to find the [Knob].
  @Deprecated('Use [knobs.updateValue] instead.')
  void updateKnobValue<T>(String label, T value) {
    knobs.updateValue<T>(label, value);
  }

  /// Update the current state using [AppRouteConfig] to update
  /// the [path], [previewMode] and [queryParams] fields. Since these fields
  /// can be manipulated from the router's query parameters, as opposed to the
  /// rest of fields that stay unchanged during runtime.
  @internal
  void updateFromRouteConfig(AppRouteConfig routeConfig) {
    path = routeConfig.path;
    query = routeConfig.query;
    previewMode = routeConfig.previewMode;
    queryParams = routeConfig.queryParams;
    panels = previewMode
        ? null // Panels are ignored in preview mode
        : routeConfig.panels
            ?.map(LayoutPanel.values.byNameOrNull)
            .nonNulls
            .toSet();

    notifyListeners();
  }

  /* Widgetbook Next: SAM (Story-Arg-Mode) Structure */

  /// Return `true` if SAM (Story-Arg-Mode) structure is used.
  @experimental
  bool get isNext => useCase is Story;

  /// Returns the current active [Story].
  @experimental
  Story? get story => isNext ? useCase as Story : null;
}

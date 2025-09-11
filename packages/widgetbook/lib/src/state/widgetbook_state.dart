import 'package:flutter/cupertino.dart'; // @docImport
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import '../core/core.dart';
import '../fields/fields.dart';
import '../integrations/widgetbook_integration.dart';
import '../navigation/navigation.dart';
import '../routing/routing.dart';
import '../utils.dart';
import 'default_app_builders.dart';
import 'default_home_page.dart';
import 'widgetbook_scope.dart';

/// Function signature for building the app wrapper around use cases.
///
/// The [AppBuilder] receives a [BuildContext] and the child widget (use case)
/// and should return a widget that wraps the child with the appropriate
/// app-level widgets like [MaterialApp], [CupertinoApp], or [WidgetsApp].
typedef AppBuilder = Widget Function(BuildContext context, Widget child);

/// Represents the main sections of the Widgetbook layout.
///
/// These panels can be shown or hidden individually to customize the
/// Widgetbook interface layout.
enum LayoutPanel {
  /// The navigation panel showing the widget directory structure.
  ///
  /// Contains the tree view of folders, components, and use cases.
  navigation,

  /// The addons panel showing global addon controls.
  ///
  /// Contains settings for viewport, theme, localization, and other addons.
  addons,

  /// The knobs panel showing use case-specific controls.
  ///
  /// Contains interactive controls for the currently selected use case.
  knobs,
}

/// Central state management for the Widgetbook application.
///
/// [WidgetbookState] maintains the current navigation state, query parameters,
/// addon configurations, knob values, and other stateful information used
/// throughout the Widgetbook application. It serves as the single source of
/// truth for the application's state.
///
/// The state is accessible throughout the widget tree using:
/// ```dart
/// final state = WidgetbookState.of(context);
/// ```
///
/// Key responsibilities:
/// * Managing current path and navigation state
/// * Synchronizing state with URL query parameters
/// * Coordinating between addons, knobs, and use cases
/// * Managing layout panel visibility
/// * Handling integrations (like Widgetbook Cloud)
///
/// The state automatically notifies listeners when changes occur, enabling
/// reactive updates throughout the UI.
class WidgetbookState extends ChangeNotifier {
  /// Creates a new instance of [WidgetbookState].
  WidgetbookState({
    this.path,
    this.query,
    this.previewMode = false,
    this.queryParams = const {},
    this.appBuilder = widgetsAppBuilder,
    this.addons,
    this.integrations,
    this.home = const DefaultHomePage(),
    this.panels = null,
    this.header,
    this.components = const [],
  }) : this.root = Tree.build(components),
       this.index = Tree.index(components);

  /// The current path in the Widgetbook.
  String? path;

  /// The current query (i.e. search) string, if any.
  String? query;

  /// Whether the Widgetbook is in preview mode.
  ///
  /// Preview mode is when only the workbench panels is shown, and all
  /// [LayoutPanel]s are hidden.
  bool previewMode;

  /// The query parameters that are used to filter the use-cases.
  Map<String, String> queryParams;

  final AppBuilder appBuilder;
  final List<Addon>? addons;
  final List<WidgetbookIntegration>? integrations;

  final List<Component> components;
  final TreeNode<Null> root;
  final Map<String, Story> index;

  /// Determines which panels are shown.
  ///
  /// - If `null`, all panels are shown.
  /// - If empty, no panels are shown (similar to [previewMode]).
  /// - If [previewMode] is `true`, the [panels] are ignored.
  ///
  /// NOTE: this forces the desktop mode, even if the screen size is small.
  Set<LayoutPanel>? panels;

  /// The home widget is a widget that is shown on startup when no use-case is
  /// selected. This widget does not inherit from the [appBuilder] or the
  /// [addons]; meaning that if `Theme.of(context)` is called inside this
  final Widget home;

  /// An optional widget to display at the top of the navigation panel.
  /// This can be used for branding or additional information.
  final Widget? header;

  Story? get story => path == null ? null : index[path!];

  /// Same as [addons] but without the ones that have no fields.
  @internal
  List<Addon>? get effectiveAddons {
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

  /// Whether the given [panel] can be shown based on the current state.
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

    final newGroupMap = Map<String, String>.from(groupMap)..update(
      field,
      (_) => value,
      ifAbsent: () => value,
    );

    updateQueryParam(
      group,
      FieldCodec.encodeQueryGroup(newGroupMap),
    );
  }

  /// Update the [path], causing a new [story] to bet returned.
  /// Resets the args during the update.
  @internal
  void updatePath(String newPath) {
    path = newPath;
    queryParams.remove('args'); // Reset args

    if (story != null) {
      integrations?.forEach(
        (integration) => integration.onStoryChange(story!),
      );
    }

    notifyListeners();
  }

  /// Updates the `q` query parameter with the given [value].
  @internal
  void updateQuery(String value) {
    query = value;
    notifyListeners();
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
    panels =
        previewMode
            ? null // Panels are ignored in preview mode
            : routeConfig.panels
                ?.map(LayoutPanel.values.byNameOrNull)
                .nonNulls
                .toSet();

    notifyListeners();
  }
}

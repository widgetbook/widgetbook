/// @docImport 'package:flutter/cupertino.dart';
/// @docImport 'package:flutter/material.dart';
library;

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import '../docs/base.dart';
import '../framework/framework.dart';
import '../navigation/navigation.dart';
import '../routing/routing.dart';
import '../utils.dart';
import 'widgetbook_scope.dart';

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

  /// The args panel showing story-specific controls.
  ///
  /// Contains interactive controls for the currently selected story.
  args,
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
/// The state automatically notifies listeners when changes occur, enabling
/// reactive updates throughout the UI.
class WidgetbookState extends ChangeNotifier {
  /// Creates a new instance of [WidgetbookState].
  WidgetbookState({
    this.config = const Config(),
    this.path,
    this.query,
    this.previewMode = false,
    this.queryGroups = const {},
    this.panels = null,
  }) : this.root = Tree.build(config);

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
  Map<String, QueryGroup> queryGroups;

  /// Determines which panels are shown.
  ///
  /// - If `null`, all panels are shown.
  /// - If empty, no panels are shown (similar to [previewMode]).
  /// - If [previewMode] is `true`, the [panels] are ignored.
  ///
  /// NOTE: this forces the desktop mode, even if the screen size is small.
  Set<LayoutPanel>? panels;

  final Config config;
  final TreeNode<Null> root;

  TreeNode? get activeNode {
    if (path == null) return null;
    return root.findByPath(path!);
  }

  /// The currently selected component, if any.
  Component? get component {
    final parentNode = activeNode?.parent;
    return parentNode is TreeNode<Component> ? parentNode.data : null;
  }

  /// The currently selected story, if any.
  Story? get story {
    final node = activeNode;
    return node is TreeNode<Story> ? node.data : null;
  }

  /// The currently selected scenario, if any.
  Scenario? get scenario {
    final node = activeNode;
    return node is TreeNode<Scenario> ? node.data : null;
  }

  /// The current selected docs, if any.
  List<DocBlock>? get docs {
    final node = activeNode;
    return node is TreeNode<List<DocBlock>> ? node.data : null;
  }

  @internal
  List<Addon>? get effectiveAddons {
    return config.addons?.where((addon) => addon.fields.isNotEmpty).toList();
  }

  /// A [Uri] representation of the current state.
  Uri get uri {
    final queryParameters = {
      if (path != null) 'path': path,
      if (query?.isNotEmpty ?? false) 'q': query,
      if (panels?.isNotEmpty ?? false)
        'panels': panels?.map((x) => x.name).join(','),
      for (final group in queryGroups.entries) group.key: group.value.toParam(),
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
        canShowPanel(LayoutPanel.args)) {
      _syncRouteInformation();
    }

    config.integrations?.forEach(
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

  /// Update the field with the given [fieldName] within the query group with
  /// the given [groupName] to the given [fieldValue].
  void updateQueryField({
    required String groupName,
    required String fieldName,
    required String fieldValue,
  }) {
    final group = queryGroups[groupName];

    final updatedGroup = group == null
        ? QueryGroup({fieldName: fieldValue})
        : group.copyWithField(fieldName, fieldValue);

    queryGroups = {
      ...queryGroups,
      groupName: updatedGroup,
    };

    notifyListeners();
  }

  /// Update the entire query group with the given [groupName] to the given
  /// [group].
  void updateQueryGroup(String groupName, QueryGroup group) {
    queryGroups = {
      ...queryGroups,
      groupName: group,
    };

    notifyListeners();
  }

  /// Navigate to the given [story].
  void goToStory(Story story) => updatePath(story.path);

  /// Navigate to the docs page of the given [component].
  void goToDocs(Component component) => updatePath(component.docsPath);

  /// Update the [path], causing a new [story] to bet returned.
  /// Resets the args during the update.
  @internal
  void updatePath(String newPath) {
    // Reset args
    final oldStory = story;

    // Reset the old story args and remove their query groups
    oldStory?.resetArgs();
    oldStory?.args.safeList.forEach(
      (arg) => queryGroups.remove(arg.groupName),
    );

    path = newPath; // Changes `story` to new one

    final newStory = story;
    if (newStory != null) {
      config.integrations?.forEach(
        (integration) => integration.onStoryChange(newStory),
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
  /// the [path], [previewMode] and [queryGroups] fields. Since these fields
  /// can be manipulated from the router's query parameters, as opposed to the
  /// rest of fields that stay unchanged during runtime.
  @internal
  void updateFromRouteConfig(AppRouteConfig routeConfig) {
    path = routeConfig.path;
    query = routeConfig.query;
    previewMode = routeConfig.previewMode;
    queryGroups = routeConfig.queryGroups;
    panels = previewMode
        ? null // Panels are ignored in preview mode
        : routeConfig.panels
              ?.map(LayoutPanel.values.byNameOrNull)
              .nonNulls
              .toSet();

    notifyListeners();
  }
}

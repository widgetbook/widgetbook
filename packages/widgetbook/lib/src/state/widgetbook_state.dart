import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import '../../next.dart';
import '../fields/fields.dart';
import '../integrations/widgetbook_integration.dart';
import '../next/navigation/tree.dart';
import '../next/navigation/tree_node.dart';
import '../routing/routing.dart';
import 'default_app_builders.dart';
import 'widgetbook_scope.dart';

typedef AppBuilder = Widget Function(BuildContext context, Widget child);

class WidgetbookState extends ChangeNotifier {
  WidgetbookState({
    this.path,
    this.query,
    this.previewMode = false,
    this.queryParams = const {},
    this.appBuilder = widgetsAppBuilder,
    this.addons,
    this.integrations,
    this.components = const [],
  })  : this.root = Tree.build(components),
        this.index = Tree.index(components);

  String? path;
  String? query;
  bool previewMode;
  Map<String, String> queryParams;

  final AppBuilder appBuilder;
  final List<Addon>? addons;
  final List<WidgetbookIntegration>? integrations;

  final List<Component> components;
  final TreeNode<Null> root;
  final Map<String, Story> index;

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
      ...queryParams,
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
      // Not backwards compatible with Flutter < 3.13.0
      // ignore: deprecated_member_use
      location: uri.toString(),
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
    notifyListeners();
  }
}

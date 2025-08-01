import 'knobs_configs.dart';

/// Annotates a builder function which is used to create the WidgetbookComponent
/// and [UseCase] for the Widgetbook
class UseCase {
  /// Creates a new annotation with [name] and [type].
  ///
  /// The [name] defines how the [UseCase] will show in the navigation
  /// area of the widgetbook.
  ///
  /// The [type] defines the Widget rendered with the UseCase. Therefore, it is
  /// used to create the WidgetElement of the Widgetbook
  const UseCase({
    required this.name,
    String? component,
    @Deprecated('Use the `component: "\$Type"` instead.') this.type,
    this.designLink,
    this.path,
    this.cloudKnobsConfigs,
    this.cloudExclude = false,
  })  : assert(
          type == null || component == null,
          'Only one of `type` or `component` can be specified',
        ),
        assert(
          type != null || component != null,
          'Either `type` or `component` must be specified',
        ),
        component = component ?? '${type}';

  /// The name of the UseCase.
  final String name;

  /// The name of the component that this UseCase belongs to.
  final String component;

  /// The type of the Widget shown in the UseCase.
  /// It is used to generate the WidgetbookComponent of the Widgetbook.
  @Deprecated('Use the `component` field instead')
  final Type? type;

  /// A link to the design for the component or use-case.
  final String? designLink;

  /// A custom path for the use-case.
  ///
  /// Folders are delimited using slashes, path segments may be made into
  /// a category by enclosing it in square brackets.
  ///
  /// For example: `[Interactions]/buttons`
  /// will produce: Interactions (category) -> buttons (folder)
  final String? path;

  /// {@macro cloud_knobs_configs}
  final KnobsConfigs? cloudKnobsConfigs;

  /// Whether to exclude this use-case from being processed by Widgetbook Cloud.
  /// All use-cases are included by default.
  final bool cloudExclude;
}

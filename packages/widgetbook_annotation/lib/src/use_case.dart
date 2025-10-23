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
    required this.type,
    this.designLink,
    this.path,
    this.cloudKnobsConfigs,
    this.exclude = false,
    this.cloudExclude = false,
  });

  /// The name of the UseCase.
  final String name;

  /// The type of the Widget shown in the UseCase.
  /// It is used to generate the WidgetbookComponent of the Widgetbook.
  final Type type;

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

  /// Whether to exclude this use-case from being processed.
  /// All use-cases are included by default.
  ///
  /// This is useful to temporarily disable a use-case without removing it.
  /// For example, when deploying to specific environments (dev vs prod).
  final bool exclude;

  /// Whether to exclude this use-case from being processed by Widgetbook Cloud.
  /// All use-cases are included by default.
  final bool cloudExclude;
}

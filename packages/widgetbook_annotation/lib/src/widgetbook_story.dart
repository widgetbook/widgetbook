/// Annotates a builder function which is used to create the WidgetElement and
/// Story for the Widgetbook
class WidgetbookStory {
  /// Creates a new annotation with [name] and [type].
  ///
  /// The [name] defines how the [WidgetbookStory] will show in the navigation
  /// area of the widgetbook.
  ///
  /// The [type] defines the Widget rendered with the Story. Therefore, it is
  /// used to create the WidgetElement of the Widgetbook
  const WidgetbookStory({
    required this.name,
    required this.type,
  });

  /// The name of the story.
  final String name;

  /// The type of the Widget shown in the Story.
  /// It is used to generate the WidgetElement of the Widgetbook.
  final Type type;
}

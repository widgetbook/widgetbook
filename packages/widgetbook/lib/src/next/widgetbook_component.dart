import 'component_metadata.dart';
import 'widgetbook_story.dart';

class WidgetbookComponent<T> {
  const WidgetbookComponent({
    required this.metadata,
    required this.stories,
  });

  final ComponentMetadata metadata;
  final List<WidgetbookStory<T>> stories;
}

import '../navigation/nodes/nodes.dart' as v3;
import 'component_metadata.dart';
import 'widgetbook_story.dart';

class WidgetbookComponent<T> extends v3.WidgetbookComponent {
  WidgetbookComponent({
    required this.metadata,
    required this.stories,
  }) : super(
          name: metadata.name,
          useCases: stories,
        );

  final ComponentMetadata<T> metadata;
  final List<WidgetbookStory<T>> stories;
}

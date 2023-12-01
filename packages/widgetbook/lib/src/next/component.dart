import '../navigation/nodes/nodes.dart' as v3;
import 'meta.dart';
import 'story.dart';

class Component<T> extends v3.WidgetbookComponent {
  Component({
    required this.meta,
    required this.stories,
  }) : super(
          name: meta.name,
          useCases: stories,
        );

  final Meta<T> meta;
  final List<Story<T>> stories;
}

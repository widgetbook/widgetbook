import 'package:widgetbook/src/repositories/memory_repository.dart';
import 'package:widgetbook/widgetbook.dart';

class StoryRepository extends MemoryRepository<WidgetbookUseCase> {
  StoryRepository({
    Map<String, WidgetbookUseCase>? initialConfiguration,
  }) : super(
          initialConfiguration: initialConfiguration,
        );
}

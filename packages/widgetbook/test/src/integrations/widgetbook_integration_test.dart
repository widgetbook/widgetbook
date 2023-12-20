import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook/next.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

class MockIntegration extends Mock implements WidgetbookIntegration {}

void main() {
  setUpAll(() {
    registerFallbackValue(MockWidgetbookState());
  });

  group(
    '$WidgetbookIntegration',
    () {
      testWidgets(
        'given an integration, '
        'when Widgetbook is initialized, '
        'then integration.onInit is called',
        (tester) async {
          final integration = MockIntegration();
          await tester.pumpWidgetWithMaterialApp(
            Widgetbook.material(
              integrations: [integration],
            ),
          );

          verify(
            () => integration.onInit(any<WidgetbookState>()),
          ).called(1);
        },
      );

      test(
        'given an integration, '
        'when state changes, '
        'then integration.onChange is called',
        () {
          final integration = MockIntegration();
          final state = WidgetbookState(
            integrations: [integration],
          );

          state.notifyListeners();

          verify(
            () => integration.onChange(state),
          ).called(1);
        },
      );

      test(
        'given an integration, '
        'when state updates path, '
        'then integration.onStoryChange is called',
        () {
          final story = MockStory();
          when(() => story.name).thenReturn('Story');

          final integration = MockIntegration();
          final state = WidgetbookState(
            queryParams: {},
            integrations: [integration],
            components: [
              Component(
                meta: Meta<Placeholder>(),
                stories: [story],
              ),
            ],
          );

          state.updatePath('Placeholder/Story');

          verify(
            () => integration.onStoryChange(story),
          ).called(1);
        },
      );
    },
  );
}

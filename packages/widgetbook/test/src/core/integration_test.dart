import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook/src/widgetbook_app.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

class MockIntegration extends Mock implements Integration {}

void main() {
  setUpAll(() {
    registerFallbackValue(MockWidgetbookState());
  });

  group(
    '$Integration',
    () {
      testWidgets(
        'given an integration, '
        'when Widgetbook is initialized, '
        'then integration.onInit is called',
        (tester) async {
          final integration = MockIntegration();
          await tester.pumpWidgetWithMaterialApp(
            WidgetbookApp(
              config: Config(
                integrations: [integration],
              ),
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
            config: Config(
              integrations: [integration],
            ),
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
          when(() => story.path).thenReturn('Placeholder/Story');

          final integration = MockIntegration();
          final state = WidgetbookState(
            config: Config(
              integrations: [integration],
              components: [
                Component(
                  name: 'Placeholder',
                  stories: [story],
                ),
              ],
            ),
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

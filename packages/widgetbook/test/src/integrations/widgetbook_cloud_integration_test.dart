import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

class MockCloudIntegration extends WidgetbookCloudIntegration {
  final VoidFn2Mock<String, List<Map<String, dynamic>>> onNotifyMock =
      VoidFn2Mock();

  @override
  void notifyCloud(
    String title,
    List<Map<String, dynamic>> data,
  ) {
    onNotifyMock.call(title, data);
  }
}

void main() {
  group(
    '$WidgetbookCloudIntegration',
    () {
      test(
        'given a state with no addons, '
        'when onInit is called, '
        'then addons data is not sent',
        () {
          final state = MockWidgetbookState();
          when(() => state.addons).thenReturn(null);

          final integration = MockCloudIntegration();
          integration.onInit(state);

          verifyNever(
            () => integration.onNotifyMock.call(any(), any()),
          );
        },
      );

      test(
        'when onInit is called, '
        'then addons data is sent',
        () {
          final state = MockWidgetbookState();
          final addons = [AlignmentAddon()];
          when(() => state.effectiveAddons).thenReturn(addons);

          final integration = MockCloudIntegration();
          integration.onInit(state);

          verify(
            () => integration.onNotifyMock.call(
              'addons',
              addons //
                  .map((addon) => addon.toJson())
                  .toList(),
            ),
          ).called(1);
        },
      );

      test(
        'when onStoryChanged is called, '
        'then args data is sent',
        () {
          final story = MockStory();
          final storyArgs = MockStoryArgs();
          final integration = MockCloudIntegration();
          const args = [
            StringArg(
              'Lorem ipsum',
              name: 'key',
            ),
          ];

          when(() => storyArgs.safeList).thenReturn(args);
          when(() => story.args).thenReturn(storyArgs);
          integration.onStoryChange(story);

          verify(
            () => integration.onNotifyMock.call(
              'args',
              args.map((arg) => arg.toJson()).toList(),
            ),
          ).called(1);
        },
      );
    },
  );
}

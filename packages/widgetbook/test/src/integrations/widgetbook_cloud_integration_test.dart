import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook/src/knobs/knobs.dart';
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
        'when onKnobsRegistered is called, '
        'then knobs data is sent',
        () {
          final state = MockWidgetbookState();
          final registry = MockKnobsRegistry();
          final knobs = {
            'key': StringKnob(
              label: 'description',
              value: 'Lorem ipsum',
            ),
          };

          when(() => registry.values).thenReturn(knobs.values);
          when(() => state.knobs).thenReturn(registry);

          final integration = MockCloudIntegration();
          integration.onKnobsRegistered(state);

          verify(
            () => integration.onNotifyMock.call(
              'knobs',
              knobs.values //
                  .map((knob) => knob.toJson())
                  .toList(),
            ),
          ).called(1);
        },
      );
    },
  );
}

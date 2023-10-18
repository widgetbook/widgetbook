import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
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
              directories: [],
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
            root: WidgetbookRoot(
              children: [],
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
        'when state notifies knobs locked, '
        'then integration.onKnobsRegistered is called',
        () {
          final integration = MockIntegration();
          final state = WidgetbookState(
            integrations: [integration],
            root: WidgetbookRoot(
              children: [],
            ),
          );

          state.knobs.lock();

          verify(
            () => integration.onKnobsRegistered(state),
          ).called(1);
        },
      );
    },
  );
}

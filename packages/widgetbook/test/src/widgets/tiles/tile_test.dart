import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/navigation/ui/navigation_panel.dart';
import 'package:widgetbook/src/providers/canvas_provider.dart';
import 'package:widgetbook/src/providers/canvas_state.dart';
import 'package:widgetbook/src/providers/theme_provider.dart';
import 'package:widgetbook/src/repositories/selected_story_repository.dart';
import 'package:widgetbook/src/repositories/story_repository.dart';
import 'package:widgetbook/widgetbook.dart';
import '../../../helper/widget_test_helper.dart';

const longString =
    'This is some text text text text text text text text text text text '
    'This is some text text text text text text text text text text text '
    'This is some text text text text text text text text text text text '
    'This is some text text text text text text text text text text text '
    'This is some text text text text text text text text text text text ';

void _testEllipses() {
  // Tests that rendering does not throw an exception
  testWidgets('Tile does not throw exception', (WidgetTester tester) async {
    await tester.pumpWidgetWithMaterialApp(
      CanvasProvider(
        storyRepository: StoryRepository(),
        onStateChanged: (_) {},
        state: CanvasState.unselected(),
        selectedStoryRepository: SelectedStoryRepository(),
        child: ThemeProvider(
          state: ThemeMode.dark,
          onStateChanged: (_) {},
          child: NavigationPanel(
            appInfo: AppInfo(name: 'test app'),
            categories: [
              WidgetbookCategory(
                name: 'category',
                widgets: [
                  WidgetbookWidget(
                    name: longString,
                    useCases: [
                      WidgetbookUseCase.child(
                        name: longString,
                        child: const Text('hi'),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }, skip: false);
}

void main() {
  group(
    'Test rendering',
    _testEllipses,
  );
}

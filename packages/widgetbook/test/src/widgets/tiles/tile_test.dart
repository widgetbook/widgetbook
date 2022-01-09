import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/providers/canvas_provider.dart';
import 'package:widgetbook/src/providers/canvas_state.dart';
import 'package:widgetbook/src/repositories/selected_story_repository.dart';
import 'package:widgetbook/src/repositories/story_repository.dart';
import 'package:widgetbook/src/widgets/tiles/tile.dart';
import 'package:widgetbook/src/widgets/tiles/tile_spacer.dart';
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
        onStateChanged: (_) {},
        selectedStoryRepository: SelectedStoryRepository(),
        state: CanvasState.unselected(),
        storyRepository: StoryRepository(),
        child: Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Tile(
                      organizer: WidgetbookFolder(
                        name: longString,
                      ),
                      iconData: Icons.style,
                      iconColor: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ],
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

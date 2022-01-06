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

void _testEllipses() {
  testWidgets('Ellipses display', (WidgetTester tester) async {
    await tester.pumpWidgetWithMaterialApp(
      CanvasProvider(
        onStateChanged: (_) {},
        selectedStoryRepository: SelectedStoryRepository(),
        state: CanvasState.unselected(),
        storyRepository: StoryRepository(),
        child: SizedBox(
          width: 0,
          child: Tile(
            organizer: WidgetbookFolder(
              name:
                  'this is a very long nasfmasifai dufgnid sngauisdgu asdugh uhiuy ygk yyhjb hajgh sdfjgsdfjlkj lsk asudg',
            ),
            iconData: Icons.style,
            iconColor: Colors.blue,
          ),
        ),
      ),
    );

    // passes but shouldnt
    //expect(find.textContaining('asudg'), findsOneWidget);
    expect(find.textContaining('...'), findsOneWidget);
  }, skip: true);
}

void main() {
  group(
    '$TileSpacer',
    _testEllipses,
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/models/models.dart';
import 'package:widgetbook/src/providers/organizer_provider.dart';
import 'package:widgetbook/src/providers/organizer_state.dart';
import 'package:widgetbook/src/repositories/selected_story_repository.dart';
import 'package:widgetbook/src/repositories/story_repository.dart';

import '../../helper.dart';

extension _WidgetTesterProviderExtension on WidgetTester {
  Future<OrganizerProvider> pumpProvider({
    required List<Category> categories,
    required StoryRepository storyRepository,
    required SelectedStoryRepository selectedStoryRepository,
  }) async {
    final provider = await pumpBuilderAndReturnProvider<OrganizerProvider>(
      OrganizerBuilder(
        categories: categories,
        storyRepository: storyRepository,
        selectedStoryRepository: selectedStoryRepository,
        child: Container(),
      ),
    );
    return provider;
  }
}

void main() {
  late StoryRepository storyRepository;
  late SelectedStoryRepository selectedStoryRepository;

  final story1 = Story(
    name: '1',
    builder: (context) => Container(),
  );

  final story2 = Story(
    name: '2',
    builder: (context) => Container(),
  );

  setUp(
    () {
      storyRepository = StoryRepository(
        initialConfiguration: <String, Story>{
          story1.name: story1,
          story2.name: story2,
        },
      );
      selectedStoryRepository = SelectedStoryRepository();
    },
  );

  group(
    '$OrganizerProvider',
    () {
      testWidgets(
        'expands $WidgetElement when the selected story changes',
        (WidgetTester tester) async {
          var provider = await tester.pumpProvider(
            categories: [
              Category(
                name: 'Category 1',
                widgets: [
                  WidgetElement(
                    name: 'Widget 1',
                    stories: [
                      story1,
                    ],
                  ),
                ],
              ),
            ],
            storyRepository: storyRepository,
            selectedStoryRepository: selectedStoryRepository,
          );

          provider = await tester.invokeMethodAndReturnPumpedProvider(
            () {
              selectedStoryRepository.setItem(story1);
            },
          );

          expect(
            provider.state.allCategories.first.widgets.first.isExpanded,
            isTrue,
          );
        },
      );

      testWidgets(
        'togglesExpander of $WidgetElement',
        (WidgetTester tester) async {
          final widgetElement = WidgetElement(
            name: 'Widget 1',
            stories: [],
          );
          var provider = await tester.pumpProvider(
            categories: [
              Category(
                name: 'Category 1',
                widgets: [widgetElement],
              ),
            ],
            storyRepository: storyRepository,
            selectedStoryRepository: selectedStoryRepository,
          );

          provider = await tester.invokeMethodAndReturnPumpedProvider(
            () {
              provider.toggleExpander(widgetElement);
            },
          );

          expect(
            provider.state,
            equals(
              OrganizerState.unfiltered(
                categories: [
                  Category(
                    name: 'Category 1',
                    widgets: [
                      WidgetElement(
                        name: 'Widget 1',
                        isExpanded: true,
                        stories: [],
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );

      testWidgets(
        'expands $WidgetElement when the selected story changes',
        (WidgetTester tester) async {
          var provider = await tester.pumpProvider(
            categories: [
              Category(
                name: 'Category 1',
                folders: [
                  Folder(
                    name: 'Folder 1',
                  ),
                ],
                widgets: [
                  WidgetElement(
                    name: 'Widget 1',
                    isExpanded: true,
                    stories: [story1, story2],
                  ),
                ],
              ),
            ],
            storyRepository: storyRepository,
            selectedStoryRepository: selectedStoryRepository,
          );

          provider = await tester.invokeMethodAndReturnPumpedProvider(
            () {
              provider.update(
                [
                  Category(
                    name: 'Category 1',
                    folders: [
                      Folder(
                        name: 'Folder 1',
                      ),
                    ],
                    widgets: [
                      // Note that this WidgetElement does not have the isExpanded
                      // property set to true
                      WidgetElement(
                        name: 'Widget 1',
                        stories: [
                          story1,
                        ],
                      ),
                    ],
                  ),
                ],
              );
            },
          );

          // Its still expected that the new structures has the isExpanded
          // property set to true
          expect(
            provider.state,
            equals(
              OrganizerState.unfiltered(
                categories: [
                  Category(
                    name: 'Category 1',
                    folders: [
                      Folder(
                        name: 'Folder 1',
                      ),
                    ],
                    widgets: [
                      // Note that this WidgetElement does have the isExpanded
                      // property set to true
                      WidgetElement(
                        name: 'Widget 1',
                        isExpanded: true,
                        stories: [
                          story1,
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );

      testWidgets(
        '.of returns $OrganizerProvider instance',
        (WidgetTester tester) async {
          await tester.pumpWidgetWithMaterialApp(
            OrganizerBuilder(
              categories: [],
              selectedStoryRepository: selectedStoryRepository,
              storyRepository: storyRepository,
              child: Container(),
            ),
          );

          final BuildContext context = tester.element(find.byType(Container));
          var provider = OrganizerProvider.of(context);
          expect(
            provider,
            isNot(null),
          );
        },
      );
    },
  );
}

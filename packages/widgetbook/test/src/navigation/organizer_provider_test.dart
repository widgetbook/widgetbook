import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook/src/models/models.dart';
import 'package:widgetbook/src/navigation/organizer_provider.dart';
import 'package:widgetbook/src/navigation/organizer_state.dart';
import 'package:widgetbook/src/repositories/story_repository.dart';
import 'package:widgetbook/src/services/filter_service.dart';
import 'package:widgetbook/src/services/sort_service.dart';

import '../../mocks/mocks.dart';

void main() {
  late StoryRepository storyRepository;

  final story1 = WidgetbookUseCase(
    name: 'Story 1',
    builder: (context) => Container(),
  );

  final story2 = WidgetbookUseCase(
    name: 'Story 2',
    builder: (context) => Container(),
  );

  setUp(
    () {
      storyRepository = StoryRepository(
        initialConfiguration: <String, WidgetbookUseCase>{
          story1.name: story1,
          story2.name: story2,
        },
      );
    },
  );

  group(
    '$OrganizerProvider',
    () {
      test(
        'togglesExpander of $WidgetbookComponent',
        () {
          final widgetElement = WidgetbookComponent(
            name: 'Widget 1',
            useCases: [],
          );

          final provider = OrganizerProvider(
            state: OrganizerState.unfiltered(
              categories: [
                WidgetbookCategory(
                  name: 'Category 1',
                  widgets: [widgetElement],
                ),
              ],
            ),
            storyRepository: storyRepository,
          )..toggleExpander(widgetElement);

          expect(
            provider.state,
            equals(
              OrganizerState.unfiltered(
                categories: [
                  WidgetbookCategory(
                    name: 'Category 1',
                    widgets: [
                      WidgetbookComponent(
                        name: 'Widget 1',
                        isExpanded: true,
                        useCases: [],
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );

      test(
        'togglesExpander of $WidgetbookComponent',
        () {
          final widgetbookCategory = WidgetbookCategory(
            name: 'Category 1',
            widgets: [
              WidgetbookComponent(
                name: 'Widget 1',
                useCases: [],
              )
            ],
          );

          final provider = OrganizerProvider(
            state: OrganizerState.unfiltered(
              categories: [
                widgetbookCategory,
              ],
            ),
            storyRepository: storyRepository,
          )..setExpandedRecursive(
              [widgetbookCategory],
              expanded: true,
            );

          expect(
            provider.state,
            equals(
              OrganizerState.unfiltered(
                categories: [
                  WidgetbookCategory(
                    name: 'Category 1',
                    widgets: [
                      WidgetbookComponent(
                        name: 'Widget 1',
                        isExpanded: true,
                        useCases: [],
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );

      test(
        'recursive expander of $WidgetbookComponent',
        () {
          final widgetCategory = WidgetbookCategory(
            name: 'Category 1',
            folders: [
              WidgetbookFolder(
                name: 'Folder 1-1',
                folders: [
                  WidgetbookFolder(
                    name: 'Folder 1-2',
                    widgets: [
                      WidgetbookComponent(
                        name: 'Widget 1-2',
                        useCases: [],
                      ),
                    ],
                  )
                ],
              ),
              WidgetbookFolder(
                name: 'Folder 2-1',
                folders: [
                  WidgetbookFolder(
                    name: 'Folder 2-2',
                    widgets: [
                      WidgetbookComponent(
                        name: 'Widget 2-2',
                        useCases: [],
                      ),
                    ],
                  )
                ],
              ),
            ],
          );

          final provider = OrganizerProvider(
            state: OrganizerState.unfiltered(
              categories: [widgetCategory],
            ),
            storyRepository: storyRepository,
          )..setExpandedRecursive(
              [widgetCategory],
              expanded: true,
            );

          expect(
            provider.state,
            equals(
              OrganizerState.unfiltered(
                categories: [
                  WidgetbookCategory(
                    name: 'Category 1',
                    folders: [
                      WidgetbookFolder(
                        name: 'Folder 1-1',
                        isExpanded: true,
                        folders: [
                          WidgetbookFolder(
                            isExpanded: true,
                            name: 'Folder 1-2',
                            widgets: [
                              WidgetbookComponent(
                                name: 'Widget 1-2',
                                useCases: [],
                                isExpanded: true,
                              ),
                            ],
                          )
                        ],
                      ),
                      WidgetbookFolder(
                        name: 'Folder 2-1',
                        isExpanded: true,
                        folders: [
                          WidgetbookFolder(
                            isExpanded: true,
                            name: 'Folder 2-2',
                            widgets: [
                              WidgetbookComponent(
                                name: 'Widget 2-2',
                                useCases: [],
                                isExpanded: true,
                              ),
                            ],
                          )
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

      test(
        'recursive expander of $WidgetbookComponent to false',
        () {
          final widgetCategory = WidgetbookCategory(
            name: 'Category 1',
            folders: [
              WidgetbookFolder(
                name: 'Folder 1-1',
                isExpanded: true,
                folders: [
                  WidgetbookFolder(
                    name: 'Folder 1-2',
                    widgets: [
                      WidgetbookComponent(
                        name: 'Widget 1-2',
                        useCases: [],
                      ),
                    ],
                  )
                ],
              ),
              WidgetbookFolder(
                name: 'Folder 2-1',
                isExpanded: true,
                folders: [
                  WidgetbookFolder(
                    name: 'Folder 2-2',
                    widgets: [
                      WidgetbookComponent(
                        name: 'Widget 2-2',
                        useCases: [],
                      ),
                    ],
                  )
                ],
              ),
            ],
          );

          final provider = OrganizerProvider(
            state: OrganizerState.unfiltered(
              categories: [widgetCategory],
            ),
            storyRepository: storyRepository,
          )..setExpandedRecursive(
              [widgetCategory],
              expanded: false,
            );

          expect(
            provider.state,
            equals(
              OrganizerState.unfiltered(
                categories: [
                  WidgetbookCategory(
                    name: 'Category 1',
                    isExpanded: false,
                    folders: [
                      WidgetbookFolder(
                        name: 'Folder 1-1',
                        folders: [
                          WidgetbookFolder(
                            name: 'Folder 1-2',
                            widgets: [
                              WidgetbookComponent(
                                name: 'Widget 1-2',
                                useCases: [],
                              ),
                            ],
                          )
                        ],
                      ),
                      WidgetbookFolder(
                        name: 'Folder 2-1',
                        folders: [
                          WidgetbookFolder(
                            name: 'Folder 2-2',
                            widgets: [
                              WidgetbookComponent(
                                name: 'Widget 2-2',
                                useCases: [],
                              ),
                            ],
                          )
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

      test(
        'expands $WidgetbookComponent when the selected story changes',
        () {
          final provider = OrganizerProvider(
            state: OrganizerState.unfiltered(
              categories: [
                WidgetbookCategory(
                  name: 'Category 1',
                  folders: [
                    WidgetbookFolder(
                      name: 'Folder 1',
                    ),
                  ],
                  widgets: [
                    WidgetbookComponent(
                      name: 'Widget 1',
                      isExpanded: true,
                      useCases: [story1, story2],
                    ),
                  ],
                ),
              ],
            ),
            storyRepository: storyRepository,
          )..hotReload(
              [
                WidgetbookCategory(
                  name: 'Category 1',
                  folders: [
                    WidgetbookFolder(
                      name: 'Folder 1',
                    ),
                  ],
                  widgets: [
                    // Note that this WidgetElement does not have the isExpanded
                    // property set to true
                    WidgetbookComponent(
                      name: 'Widget 1',
                      useCases: [
                        story1,
                      ],
                    ),
                  ],
                ),
              ],
            );

          // Its still expected that the new structures has the isExpanded
          // property set to true
          expect(
            provider.state,
            equals(
              OrganizerState.unfiltered(
                categories: [
                  WidgetbookCategory(
                    name: 'Category 1',
                    folders: [
                      WidgetbookFolder(
                        name: 'Folder 1',
                      ),
                    ],
                    widgets: [
                      // Note that this WidgetElement does have the isExpanded
                      // property set to true
                      WidgetbookComponent(
                        name: 'Widget 1',
                        isExpanded: true,
                        useCases: [
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

      test(
        'resets filter when resetFilter is called',
        () {
          final folder = WidgetbookFolder(
            name: 'Folder 1',
          );
          final category = WidgetbookCategory(
            name: 'Category 1',
            folders: [
              folder,
            ],
            widgets: [
              WidgetbookComponent(
                name: 'Widget 1',
                isExpanded: true,
                useCases: [
                  story1,
                  story2,
                ],
              ),
            ],
          );

          final filteredCategory = WidgetbookCategory(
            name: 'Category 1',
            folders: [
              folder,
            ],
          );

          final provider = OrganizerProvider(
            state: OrganizerState(
              allCategories: [
                category,
              ],
              filteredCategories: [
                filteredCategory,
              ],
              searchTerm: 'does not really matter',
            ),
            storyRepository: storyRepository,
          )..resetFilter();

          expect(
            provider.state,
            equals(
              OrganizerState.unfiltered(
                categories: [
                  category,
                ],
              ),
            ),
          );
        },
      );

      test(
        'invokes $FilterService when filter is called',
        () {
          final folder = WidgetbookFolder(
            name: 'Folder 1',
          );
          final category = WidgetbookCategory(
            name: 'Category 1',
            folders: [
              folder,
            ],
            widgets: [
              WidgetbookComponent(
                name: 'Widget 1',
                isExpanded: true,
                useCases: [
                  story1,
                  story2,
                ],
              ),
            ],
          );

          const searchTerm = 'does not really matter';

          final filterService = FilterServiceMock();
          when(
            () => filterService.filter(
              searchTerm,
              [
                category,
              ],
            ),
          ).thenReturn(
            [
              category,
            ],
          );

          final provider = OrganizerProvider(
            state: OrganizerState.unfiltered(
              categories: [
                category,
              ],
            ),
            storyRepository: storyRepository,
            filterService: filterService,
          )..filter(searchTerm);

          verify(
            () => filterService.filter(
              searchTerm,
              [
                category,
              ],
            ),
          ).called(1);

          expect(
            provider.state,
            equals(
              OrganizerState(
                allCategories: [
                  category,
                ],
                filteredCategories: [category],
                searchTerm: searchTerm,
              ),
            ),
          );
        },
      );

      test('invokes $SortService when sort is called', () {
        final category1 = WidgetbookCategory(name: 'Category 1');
        final category2 = WidgetbookCategory(name: 'Category 2');

        final sortService = SortServiceMock();
        when(() => sortService.sort([category2, category1], Sorting.asc))
            .thenReturn([category1, category2]);

        final provider = OrganizerProvider(
          state: OrganizerState.unfiltered(categories: [category2, category1]),
          storyRepository: storyRepository,
          sortService: sortService,
        )..sort(Sorting.asc);

        verify(() => sortService.sort([category2, category1], Sorting.asc))
            .called(1);

        expect(
          provider.state,
          equals(
            OrganizerState(
              allCategories: [category2, category1],
              filteredCategories: [category1, category2],
              searchTerm: '',
              sorting: Sorting.asc,
            ),
          ),
        );
      });

      test('resets sorting when resetSort is called', () {
        final category1 = WidgetbookCategory(name: 'Category 1');
        final category2 = WidgetbookCategory(name: 'Category 2');

        final sortService = SortServiceMock();

        final provider = OrganizerProvider(
          state: OrganizerState(
            allCategories: [category2, category1],
            filteredCategories: [category1, category2],
            searchTerm: '',
            sorting: Sorting.asc,
          ),
          storyRepository: storyRepository,
          sortService: sortService,
        )..resetSort();

        verifyZeroInteractions(sortService);
        expect(
          provider.state,
          equals(
            OrganizerState(
              allCategories: [category2, category1],
              filteredCategories: [category2, category1],
              searchTerm: '',
            ),
          ),
        );
      });

      test('keeps items sorted when new filter is applied', () {
        final category1 = WidgetbookCategory(name: 'Category 1');
        final category2 = WidgetbookCategory(name: 'Category 2');
        final category3 = WidgetbookCategory(name: 'Category 3');
        const tSearchTerm = 'filter out category2 at all costs';
        final tAllCategories = [category3, category2, category1];
        final tFilteredCategories = [category3, category1];
        final expectedFilteredCategories = [category1, category3];

        final filterService = FilterServiceMock();
        when(() => filterService.filter(tSearchTerm, tAllCategories))
            .thenReturn(tFilteredCategories);

        final sortService = SortServiceMock();
        when(() => sortService.sort(tFilteredCategories, Sorting.asc))
            .thenReturn(expectedFilteredCategories);

        final provider = OrganizerProvider(
          state: OrganizerState(
            allCategories: tAllCategories,
            filteredCategories: tAllCategories.reversed.toList(),
            searchTerm: '',
            sorting: Sorting.asc,
          ),
          storyRepository: storyRepository,
          sortService: sortService,
          filterService: filterService,
        )..filter(tSearchTerm);

        verify(() => filterService.filter(tSearchTerm, tAllCategories))
            .called(1);
        verify(() => sortService.sort(tFilteredCategories, Sorting.asc))
            .called(1);

        expect(
          provider.state,
          equals(
            OrganizerState(
              allCategories: tAllCategories,
              filteredCategories: expectedFilteredCategories,
              searchTerm: tSearchTerm,
              sorting: Sorting.asc,
            ),
          ),
        );
      });

      test('keeps items filtered when new sorting is applied', () {
        final category1 = WidgetbookCategory(name: 'Category 1');
        final category2 = WidgetbookCategory(name: 'Category 2');
        final category3 = WidgetbookCategory(name: 'Category 3');
        const tSearchTerm = "doesn't really matter";
        final tAllCategories = [category3, category2, category1];
        final tFilteredCategories = [category3, category1];
        final expectedFilteredCategories = [category1, category3];

        final filterService = FilterServiceMock();
        when(() => filterService.filter(tSearchTerm, tAllCategories))
            .thenReturn(tFilteredCategories);

        final sortService = SortServiceMock();
        when(() => sortService.sort(tFilteredCategories, Sorting.asc))
            .thenReturn(expectedFilteredCategories);

        final provider = OrganizerProvider(
          state: OrganizerState(
            allCategories: tAllCategories,
            filteredCategories: tFilteredCategories,
            searchTerm: tSearchTerm,
            sorting: Sorting.desc,
          ),
          storyRepository: storyRepository,
          sortService: sortService,
          filterService: filterService,
        )..sort(Sorting.asc);

        verify(() => filterService.filter(tSearchTerm, tAllCategories))
            .called(1);
        verify(() => sortService.sort(tFilteredCategories, Sorting.asc))
            .called(1);

        expect(
          provider.state,
          equals(
            OrganizerState(
              allCategories: tAllCategories,
              filteredCategories: expectedFilteredCategories,
              searchTerm: tSearchTerm,
              sorting: Sorting.asc,
            ),
          ),
        );
      });
    },
  );
}

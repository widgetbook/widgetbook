import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/repositories/selected_use_case_repository.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  late SelectedUseCaseRepository selectedStoryRepository;

  final useCase1 = WidgetbookUseCase(
    name: 'Use Case 1',
    builder: (_) => const Center(),
  );

  final useCase2 = WidgetbookUseCase(
    name: 'Use Case 2',
    builder: (_) => const Center(),
  );

  final useCase3 = WidgetbookUseCase(
    name: 'Use Case 3',
    builder: (_) => const Center(),
  );

  final useCase4 = WidgetbookUseCase(
    name: 'Use Case 4',
    builder: (_) => const Center(),
  );

  setUp(() {
    selectedStoryRepository = SelectedUseCaseRepository();
  });

  group('$UseCasesProvider', () {
    test('Loads use cases with their paths from directories', () {
      final directories = [
        WidgetbookCategory(
          name: 'Test Category',
          children: [
            WidgetbookFolder(
              name: 'Test Folder',
              children: [
                WidgetbookComponent(
                  name: 'Test Component',
                  useCases: [
                    useCase1,
                    useCase2,
                  ],
                ),
              ],
            ),
          ],
        ),
        WidgetbookFolder(
          name: 'Test Folder',
          children: [
            WidgetbookComponent(
              name: 'Test Component 1',
              useCases: [
                useCase3,
                useCase4,
              ],
            ),
          ],
        ),
      ];

      final expectedUseCases = {
        'test-category/test-folder/test-component/use-case-1': useCase1,
        'test-category/test-folder/test-component/use-case-2': useCase2,
        'test-folder/test-component-1/use-case-3': useCase3,
        'test-folder/test-component-1/use-case-4': useCase4,
      };

      final useCaseProvider = UseCasesProvider(
        selectedStoryRepository: selectedStoryRepository,
      )..loadFromDirectories(directories);

      expect(
        useCaseProvider.state.useCases,
        equals(expectedUseCases),
      );
    });

    test(
      'can select $WidgetbookUseCase by path',
      () {
        final useCase = {
          'component/use-case-1': useCase1,
          'component/use-case-2': useCase2,
        };

        final useCasesProvider = UseCasesProvider(
          state: UseCasesState(useCases: useCase),
          selectedStoryRepository: selectedStoryRepository,
        )..selectUseCaseByPath('component/use-case-1');

        expect(
          useCasesProvider.state.selectedUseCase,
          equals(useCase1),
        );
      },
    );
  });
}

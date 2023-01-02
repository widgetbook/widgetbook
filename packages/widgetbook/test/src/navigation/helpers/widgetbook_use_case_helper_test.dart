import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/navigation/helpers/widgetbook_use_case_helper.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  final nodes = [
    WidgetbookPackage(
      name: 'Package',
      children: [
        WidgetbookCategory(
          name: 'Category',
          children: [
            WidgetbookComponent(
              name: 'Component',
              useCases: [
                WidgetbookUseCase(
                  name: 'UseCase 1',
                  builder: (context) => Container(),
                ),
              ],
            ),
          ],
        ),
        WidgetbookComponent(
          name: 'Component',
          useCases: [
            WidgetbookUseCase(
              name: 'UseCase 2',
              builder: (context) => Container(),
            ),
          ],
        )
      ],
    ),
    WidgetbookComponent(
      name: 'Component',
      useCases: [
        WidgetbookUseCase(
          name: 'UseCase 3',
          builder: (context) => Container(),
        ),
      ],
    ),
  ];

  group(
    '$WidgetbookUseCaseHelper',
    () {
      test(
        'Can get all $WidgetbookUseCase items from navigation tree',
        () {
          final expectedUseCases = [
            WidgetbookUseCase(
              name: 'UseCase 1',
              builder: (context) => Container(),
            ),
            WidgetbookUseCase(
              name: 'UseCase 2',
              builder: (context) => Container(),
            ),
            WidgetbookUseCase(
              name: 'UseCase 3',
              builder: (context) => Container(),
            ),
          ];

          expect(
            WidgetbookUseCaseHelper.fromNodes(nodes),
            equals(expectedUseCases),
          );
        },
      );
    },
    // Todo: make this test work
    skip: true,
  );
}

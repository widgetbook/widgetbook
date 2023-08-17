import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

final root = WidgetbookRoot(
  children: [
    WidgetbookPackage(
      name: 'Package',
      children: [
        WidgetbookCategory(
          name: 'Category',
          children: [
            WidgetbookFolder(
              name: 'Folder 1',
              children: [
                WidgetbookComponent(
                  name: 'Component 1',
                  useCases: [
                    WidgetbookUseCase(
                      name: 'Use Case 1',
                      builder: (_) => const SizedBox(),
                    ),
                    WidgetbookUseCase(
                      name: 'Use Case 2',
                      builder: (_) => const SizedBox(),
                    ),
                  ],
                ),
                WidgetbookComponent(
                  name: 'Component 2',
                  useCases: [
                    WidgetbookUseCase(
                      name: 'Use Case 1',
                      builder: (_) => const SizedBox(),
                    ),
                  ],
                ),
              ],
            ),
            WidgetbookFolder(
              name: 'Folder 2',
              children: [
                WidgetbookComponent(
                  name: 'Component 1',
                  useCases: [
                    WidgetbookUseCase(
                      name: 'Use Case 1',
                      builder: (_) => const SizedBox(),
                    ),
                    WidgetbookUseCase(
                      name: 'Use Case 2',
                      builder: (_) => const SizedBox(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);

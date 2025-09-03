import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

final treeRoot = WidgetbookRoot(
  children: [
    WidgetbookFolder(
      name: 'Folder 1',
      children: [
        WidgetbookComponent(
          // Leaf component
          name: 'Component 1',
          useCases: [
            WidgetbookUseCase(
              name: 'Use-case 1',
              builder: (_) => Container(),
            ),
          ],
        ),
      ],
    ),
    WidgetbookFolder(
      name: 'Folder 2',
      children: [
        WidgetbookComponent(
          name: 'Component 2',
          useCases: [
            WidgetbookUseCase(
              name: 'Use-case 2a',
              builder: (_) => Container(),
            ),
            WidgetbookUseCase(
              name: 'Use-case 2b',
              builder: (_) => Container(),
            ),
          ],
        ),
      ],
    ),
  ],
);

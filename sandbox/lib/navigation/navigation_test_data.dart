// ignore_for_file: invalid_use_of_internal_member

import 'package:flutter/material.dart';
import 'package:widgetbook/src/navigation/navigation.dart';

final directories = [
  WidgetbookPackage(
    name: 'Package',
    children: [
      WidgetbookComponent(
        name: 'Component',
        useCases: [
          WidgetbookUseCase(
            name: 'Use Case 1',
            builder: (_) => const SizedBox.shrink(),
          ),
        ],
      )
    ],
  ),
  WidgetbookCategory(
    name: 'Category',
    children: [
      WidgetbookComponent(
        name: 'Component',
        useCases: [
          WidgetbookUseCase(
            name: 'Use Case 2',
            builder: (_) => const SizedBox.shrink(),
          ),
          WidgetbookUseCase(
            name: 'Use Case 3',
            builder: (_) => const SizedBox.shrink(),
          ),
        ],
      ),
    ],
  ),
];

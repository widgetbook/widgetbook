// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

import 'package:full_example/components/container.dart';
import 'package:full_example/components/custom_card.dart';
import 'package:full_example/components/custom_text_field.dart';
import 'package:full_example/customs/custom_knob.dart';
import 'package:widgetbook/widgetbook.dart';

final directories = [
  WidgetbookFolder(
    name: 'widgets',
    children: [
      WidgetbookComponent(
        name: 'Container',
        useCases: [
          WidgetbookUseCase(
            name: 'with green color',
            builder: (context) => greenContainerUseCase(context),
          ),
          WidgetbookUseCase(
            name: 'with different title',
            builder: (context) => myWidget(context),
          ),
        ],
      ),
    ],
  ),
  WidgetbookFolder(
    name: 'components',
    children: [
      WidgetbookComponent(
        name: 'CustomTextField',
        useCases: [
          WidgetbookUseCase(
            name: 'Default Style',
            builder: (context) => defaultCustomTextField(context),
          ),
          WidgetbookUseCase(
            name: 'With Hint Text',
            builder: (context) => hintTextCustomTextField(context),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'CustomCard',
        useCases: [
          WidgetbookUseCase(
            name: 'Default Style',
            builder: (context) => defaultCustomCard(context),
          ),
          WidgetbookUseCase(
            name: 'With Custom Background Color',
            builder: (context) => customBackgroundCustomCard(context),
          ),
        ],
      ),
    ],
  ),
  WidgetbookFolder(
    name: 'material',
    children: [
      WidgetbookComponent(
        name: 'RangeSlider',
        useCases: [
          WidgetbookUseCase(
            name: 'CustomRangeSlider',
            builder: (context) => rangeSlider(context),
          ),
        ],
      ),
    ],
  ),
];

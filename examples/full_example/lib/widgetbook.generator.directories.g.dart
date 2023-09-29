// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:full_example/components/container.dart' as _i5;
import 'package:full_example/components/custom_card.dart' as _i2;
import 'package:full_example/components/custom_text_field.dart' as _i3;
import 'package:full_example/customs/custom_knob.dart' as _i4;
import 'package:widgetbook/widgetbook.dart' as _i1;

final directories = <_i1.WidgetbookNode>[
  _i1.WidgetbookFolder(
    name: 'components',
    children: [
      _i1.WidgetbookComponent(
        name: 'CustomCard',
        useCases: [
          _i1.WidgetbookUseCase(
            name: 'Default Style',
            builder: _i2.defaultCustomCard,
          ),
          _i1.WidgetbookUseCase(
            name: 'With Custom Background Color',
            builder: _i2.customBackgroundCustomCard,
          ),
        ],
      ),
      _i1.WidgetbookComponent(
        name: 'CustomTextField',
        useCases: [
          _i1.WidgetbookUseCase(
            name: 'Default Style',
            builder: _i3.defaultCustomTextField,
          ),
          _i1.WidgetbookUseCase(
            name: 'With Hint Text',
            builder: _i3.hintTextCustomTextField,
          ),
        ],
      ),
    ],
  ),
  _i1.WidgetbookFolder(
    name: 'material',
    children: [
      _i1.WidgetbookComponent(
        name: 'RangeSlider',
        useCases: [
          _i1.WidgetbookUseCase(
            name: 'CustomRangeSlider',
            builder: _i4.rangeSlider,
          )
        ],
      )
    ],
  ),
  _i1.WidgetbookFolder(
    name: 'widgets',
    children: [
      _i1.WidgetbookComponent(
        name: 'Container',
        useCases: [
          _i1.WidgetbookUseCase(
            name: 'with different title',
            builder: _i5.myWidget,
          ),
          _i1.WidgetbookUseCase(
            name: 'with green color',
            builder: _i5.greenContainerUseCase,
          ),
        ],
      )
    ],
  ),
];

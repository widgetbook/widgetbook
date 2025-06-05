// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:full_example/components/container.dart' as _i3;
import 'package:full_example/components/custom_card.dart' as _i2;
import 'package:full_example/components/custom_text_field.dart' as _i4;
import 'package:full_example/components/stepped_counter.dart' as _i5;
import 'package:full_example/customs/custom_knob.dart' as _i6;
import 'package:widgetbook/widgetbook.dart' as _i1;

final directories = <_i1.WidgetbookNode>[
  _i1.WidgetbookCategory(
    name: 'components',
    children: [
      _i1.WidgetbookFolder(
        name: 'CustomCard',
        children: [
          _i1.WidgetbookFolder(
            name: 'default_style',
            children: [
              _i1.WidgetbookLeafComponent(
                name: 'CustomCard',
                useCase: _i1.WidgetbookUseCase(
                  name: 'Default Style',
                  builder: _i2.defaultCustomCard,
                ),
              )
            ],
          ),
          _i1.WidgetbookFolder(
            name: 'with_custom_background_color',
            children: [
              _i1.WidgetbookLeafComponent(
                name: 'CustomCard',
                useCase: _i1.WidgetbookUseCase(
                  name: 'With Custom Background Color',
                  builder: _i2.customBackgroundCustomCard,
                ),
              )
            ],
          ),
        ],
      )
    ],
  ),
  _i1.WidgetbookCategory(
    name: 'widgets',
    children: [
      _i1.WidgetbookFolder(
        name: 'containers',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'Container',
            useCase: _i1.WidgetbookUseCase(
              name: 'Component',
              builder: _i3.myWidget,
            ),
          )
        ],
      )
    ],
  ),
  _i1.WidgetbookFolder(
    name: 'components',
    children: [
      _i1.WidgetbookComponent(
        name: 'CustomTextField',
        useCases: [
          _i1.WidgetbookUseCase(
            name: 'Default Style',
            builder: _i4.defaultCustomTextField,
          ),
          _i1.WidgetbookUseCase(
            name: 'With Hint Text',
            builder: _i4.hintTextCustomTextField,
          ),
        ],
      ),
      _i1.WidgetbookLeafComponent(
        name: 'SteppedCounter',
        useCase: _i1.WidgetbookUseCase(
          name: 'Default',
          builder: _i5.steppedCounterUseCase,
        ),
      ),
    ],
  ),
  _i1.WidgetbookFolder(
    name: 'material',
    children: [
      _i1.WidgetbookLeafComponent(
        name: 'RangeSlider',
        useCase: _i1.WidgetbookUseCase(
          name: 'CustomRangeSlider',
          builder: _i6.rangeSlider,
        ),
      )
    ],
  ),
];

// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:full_example/components/container.dart'
    as _full_example_components_container;
import 'package:full_example/components/custom_card.dart'
    as _full_example_components_custom_card;
import 'package:full_example/components/custom_text_field.dart'
    as _full_example_components_custom_text_field;
import 'package:full_example/components/stepped_counter.dart'
    as _full_example_components_stepped_counter;
import 'package:full_example/customs/custom_knob.dart'
    as _full_example_customs_custom_knob;
import 'package:widgetbook/widgetbook.dart' as _widgetbook;

final directories = <_widgetbook.WidgetbookNode>[
  _widgetbook.WidgetbookCategory(
    name: 'widgets',
    children: [
      _widgetbook.WidgetbookFolder(
        name: 'containers',
        children: [
          _widgetbook.WidgetbookComponent(
            name: 'Container',
            useCases: [
              _widgetbook.WidgetbookUseCase(
                name: 'with different title',
                builder: _full_example_components_container.myWidget,
              ),
              _widgetbook.WidgetbookUseCase(
                name: 'with green color',
                builder:
                    _full_example_components_container.greenContainerUseCase,
              ),
            ],
          ),
        ],
      ),
    ],
  ),
  _widgetbook.WidgetbookFolder(
    name: 'components',
    children: [
      _widgetbook.WidgetbookComponent(
        name: 'CustomCard',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Default Style',
            builder: _full_example_components_custom_card.defaultCustomCard,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'With Custom Background Color',
            builder:
                _full_example_components_custom_card.customBackgroundCustomCard,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'CustomTextField',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Default Style',
            builder: _full_example_components_custom_text_field
                .defaultCustomTextField,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'With Hint Text',
            builder: _full_example_components_custom_text_field
                .hintTextCustomTextField,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'SteppedCounter',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Default',
            builder:
                _full_example_components_stepped_counter.steppedCounterUseCase,
          ),
        ],
      ),
    ],
  ),
  _widgetbook.WidgetbookFolder(
    name: 'material',
    children: [
      _widgetbook.WidgetbookComponent(
        name: 'RangeSlider',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'CustomRangeSlider',
            builder: _full_example_customs_custom_knob.rangeSlider,
          ),
        ],
      ),
    ],
  ),
];

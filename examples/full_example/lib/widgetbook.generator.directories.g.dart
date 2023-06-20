// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

import 'dart:async';
import 'dart:core';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/material/constants.dart';
import 'package:flutter/src/material/debug.dart';
import 'package:flutter/src/material/material_state.dart';
import 'package:flutter/src/material/slider_theme.dart';
import 'package:flutter/src/material/theme.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/image.dart';
import 'package:flutter/widgets.dart';
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

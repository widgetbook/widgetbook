// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// WidgetbookGenerator
// **************************************************************************

import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screen_util_example/example.dart';
import 'package:screen_util_example/image_page.dart';
import 'package:widgetbook/widgetbook.dart';

final directories = [
  WidgetbookComponent(
    name: 'ImagePage',
    useCases: [
      WidgetbookUseCase(
        name: 'Example',
        builder: (context) => testUseCase(context),
      ),
    ],
  ),
  WidgetbookComponent(
    name: 'ScreenUtilExample',
    useCases: [
      WidgetbookUseCase(
        name: 'show screen height and width',
        builder: (context) => exampleBuilder(context),
      ),
    ],
  ),
];

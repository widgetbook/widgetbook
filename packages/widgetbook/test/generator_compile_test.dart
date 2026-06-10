// Compile-checks all generator fixtures and their golden part files.
//
// The golden tests (`test/generator/*/*_test.dart`) only compare the
// generated output as text, and `**/*.g.dart` is excluded from analysis,
// so invalid generated code would otherwise go unnoticed. Importing the
// fixtures here forces `flutter test` to compile every `.stories.dart`
// together with its `.stories.g.dart` golden.
//
// This file intentionally lives outside `test/generator/`, as it cannot be
// loaded by `dart test test/generator/ --platform vm` (flutter_test requires
// `dart:ui`).

import 'package:flutter_test/flutter_test.dart';

import 'generator/default_values/default_values.stories.dart'
    as default_values;
import 'generator/doc_comment/doc_comment.stories.dart' as doc_comment;
import 'generator/doc_comment_code/doc_comment_code.stories.dart'
    as doc_comment_code;
import 'generator/enums/enums.stories.dart' as enums;
import 'generator/generic/generic.stories.dart' as generic;
import 'generator/generic_bound/generic_bound.stories.dart' as generic_bound;
import 'generator/generic_bound_dynamic/generic_bound_dynamic.stories.dart'
    as generic_bound_dynamic;
import 'generator/generic_bound_nullable/generic_bound_nullable.stories.dart'
    as generic_bound_nullable;
import 'generator/custom_args/custom_args.stories.dart' as custom_args;
import 'generator/multi_constructor/multi_constructor.stories.dart'
    as multi_constructor;
import 'generator/nullable/nullable.stories.dart' as nullable;
import 'generator/primitive/primitive.stories.dart' as primitive;
import 'generator/static_methods/static_methods.stories.dart'
    as static_methods;
import 'generator/variants/variants.stories.dart' as variants;
import 'generator/with_defaults/with_defaults.stories.dart' as with_defaults;

void main() {
  test('all generator fixtures compile against their goldens', () {
    final components = [
      default_values.DefaultsWidgetComponent,
      doc_comment.DocCommentWidgetComponent,
      doc_comment_code.DocCommentCodeWidgetComponent,
      enums.EnumWidgetComponent,
      generic.GenericWidgetComponent,
      generic_bound.BoundWidgetComponent,
      generic_bound_dynamic.DynamicBoundWidgetComponent,
      generic_bound_nullable.NullableBoundWidgetComponent,
      custom_args.LabelBadgeComponent,
      multi_constructor.MultiConstructorWidgetComponent,
      nullable.NullableWidgetComponent,
      primitive.PrimitiveWidgetComponent,
      static_methods.StaticMethodWidgetComponent,
      variants.VariantButtonComponent,
      with_defaults.DefaultsVarWidgetComponent,
    ];

    expect(components, isNotEmpty);
  });
}

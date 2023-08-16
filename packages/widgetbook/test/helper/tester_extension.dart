import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/state/widgetbook_scope.dart';
import 'package:widgetbook/src/themes.dart';
import 'package:widgetbook/widgetbook.dart';

extension TesterExtension on WidgetTester {
  /// Executes [tap] on the [finder] then [pumpAndSettle].
  Future<Finder> findAndTap(Finder finder) async {
    await tap(finder);
    await pumpAndSettle();
    return finder;
  }

  /// Executes [drag] on the [finder] with [offset] then [pumpAndSettle].
  Future<Finder> findAndDrag(Finder finder, Offset offset) async {
    await drag(finder, offset);
    await pumpAndSettle();
    return finder;
  }

  /// Executes [enterText] on the [finder] with [text] then [pumpAndSettle].
  Future<Finder> findAndEnter(Finder finder, String text) async {
    await enterText(finder, text);
    await pumpAndSettle();
    return finder;
  }

  /// Wraps [widget] with a [MaterialApp] predefined with [Themes]
  Future<void> pumpWidgetWithMaterialApp(Widget widget) async {
    return pumpWidget(
      MaterialApp(
        theme: Themes.dark,
        home: Scaffold(
          body: widget,
        ),
      ),
    );
  }

  /// Same as [pumpWidgetWithMaterialApp] but with a [BuildContext].
  Future<void> pumpWidgetWithBuilder(WidgetBuilder builder) async {
    return pumpWidgetWithMaterialApp(
      Builder(
        builder: builder,
      ),
    );
  }

  Future<WidgetbookState> pumpWidgetWithState({
    required WidgetbookState state,
    required WidgetBuilder builder,
  }) async {
    await pumpWidgetWithMaterialApp(
      WidgetbookScope(
        state: state,
        child: Builder(
          builder: builder,
        ),
      ),
    );

    return state;
  }

  Future<WidgetbookState> pumpWidgetWithQueryParams({
    required Map<String, String> queryParams,
    required WidgetBuilder builder,
  }) async {
    final state = WidgetbookState(
      queryParams: queryParams,
      root: WidgetbookRoot(
        children: [],
      ),
    );

    return pumpWidgetWithState(
      state: state,
      builder: builder,
    );
  }

  /// Pumps a [Field]'s widget using [value] as a query parameter to the field,
  /// then returns the widget of type [TWidget].
  Future<TWidget> pumpField<TValue, TWidget extends Widget>(
    Field<TValue> field,
    TValue? value,
  ) async {
    const group = 'group_name';

    await pumpWidgetWithQueryParams(
      queryParams: value != null
          ? {group: '{${field.name}:${field.codec.toParam(value)}}'}
          : {},
      builder: (context) => field.build(context, group),
    );

    return widget<TWidget>(
      find.byType(TWidget),
    );
  }

  Future<void> pumpKnob(WidgetBuilder builder) async {
    await pumpWidgetWithQueryParams(
      queryParams: {},
      builder: (context) {
        final state = WidgetbookState.of(context);

        return Column(
          children: [
            builder(context),
            ...state.knobs.values.map(
              (knob) => knob.buildFields(context),
            ),
          ],
        );
      },
    );
  }
}

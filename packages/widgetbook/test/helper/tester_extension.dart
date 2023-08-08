import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/state/widgetbook_scope.dart';
import 'package:widgetbook/src/themes.dart';
import 'package:widgetbook/widgetbook.dart';

extension TesterExtension on WidgetTester {
  /// Wraps [widget] with a [MaterialApp] predefined with [Themes]
  Future<void> pumpWidgetWithMaterialApp(Widget widget) async {
    return pumpWidget(
      MaterialApp(
        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode: ThemeMode.dark,
        home: Scaffold(
          body: widget,
        ),
      ),
    );
  }

  /// Same as [pumpWidgetWithMaterialApp] but with a [BuildContext].
  Future<void> pumpWidgetWithBuilder(WidgetBuilder builder) async {
    return pumpWidgetWithMaterialApp(
      Scaffold(
        body: Builder(
          builder: builder,
        ),
      ),
    );
  }

  Future<WidgetbookState> pumpWidgetWithQueryParams({
    required Map<String, String> queryParams,
    required WidgetBuilder builder,
  }) async {
    final state = WidgetbookState(
      appBuilder: materialAppBuilder,
      directories: [],
      queryParams: queryParams,
    );

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
            Expanded(
              child: builder(context),
            ),
            ...state.knobs.values.map(
              (knob) => Material(
                child: knob.buildFields(context),
              ),
            ),
          ],
        );
      },
    );
  }
}

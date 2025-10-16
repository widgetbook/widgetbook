import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/state/state.dart';
import 'package:widgetbook/src/theme/theme.dart';
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
        home: Builder(
          builder: (context) {
            return WidgetbookTheme(
              data: Theme.of(context),
              child: Scaffold(
                body: widget,
              ),
            );
          },
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

  Future<WidgetbookState> pumpWidgetWithQueryGroups({
    required Map<String, QueryGroup> queryGroups,
    required WidgetBuilder builder,
  }) async {
    final state = WidgetbookState(
      queryGroups: queryGroups,
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
    const groupName = 'group_name';
    final group =
        value != null
            ? QueryGroup({field.name: field.toParam(value)})
            : QueryGroup.empty;

    await pumpWidgetWithQueryGroups(
      queryGroups: value != null ? {groupName: group} : {},
      builder: (context) => field.build(context, groupName),
    );

    return widget<TWidget>(
      find.byType(TWidget),
    );
  }
}

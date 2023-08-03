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
    return pumpWidget(
      MaterialApp(
        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode: ThemeMode.dark,
        home: Scaffold(
          body: Builder(
            builder: builder,
          ),
        ),
      ),
    );
  }

  /// Executes [tap] on the [finder] then [pumpAndSettle].
  Future<Finder> findAndTap(Finder finder) async {
    await tap(finder);
    await pumpAndSettle();
    return finder;
  }

  /// Pumps a [Field]'s widget using [value] as a query parameter to the field,
  /// then returns the widget of type [TWidget].
  Future<TWidget> pumpField<TValue, TWidget extends Widget>(
    Field<TValue> field,
    TValue? value,
  ) async {
    const groupName = 'group_name';

    await pumpWidgetWithMaterialApp(
      WidgetbookScope(
        state: WidgetbookState(
          directories: [],
          appBuilder: (context, child) => child,
          queryParams: (value == null)
              ? {}
              : {
                  groupName: '{${field.name}:${field.codec.toParam(value)}}',
                },
        ),
        child: Builder(
          builder: (context) {
            return field.build(
              context,
              groupName,
            );
          },
        ),
      ),
    );

    return widget<TWidget>(
      find.byType(TWidget),
    );
  }
}

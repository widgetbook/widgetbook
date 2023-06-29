import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/state/state.dart';

typedef WidgetBuilder = Widget Function(BuildContext context);

extension KnobHelper on WidgetTester {
  Future<void> pumpWithKnob(
    WidgetBuilder builder,
  ) async {
    return pumpWidget(
      WidgetbookScope(
        state: WidgetbookState(
          path: '/',
          queryParams: {},
          addons: [],
          directories: [],
          appBuilder: materialAppBuilder,
        ),
        child: MaterialApp(
          home: Builder(
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
          ),
        ),
      ),
    );
  }
}

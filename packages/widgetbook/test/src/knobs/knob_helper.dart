import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/state/state.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

typedef WidgetBuilder = Widget Function(BuildContext context);

extension KnobHelper on WidgetTester {
  Future<void> pumpWithKnob(
    WidgetBuilder builder,
  ) async {
    return pumpWidget(
      WidgetbookScope(
        state: WidgetbookState(
          path: '/',
          panels: {},
          queryParams: {},
          addons: [],
          catalog: WidgetbookCatalog.fromDirectories([]),
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
                      child: KnobProperty(
                        name: knob.label,
                        description: knob.description,
                        value: knob.value,
                        isNullable: knob.isNullable,
                        changedNullable: (isEnabled) {
                          state.updateKnobNullability(
                            knob.label,
                            !isEnabled,
                          );
                        },
                        child: Column(
                          children: knob.fields
                              .map((field) => field.build(context))
                              .toList(),
                        ),
                      ),
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

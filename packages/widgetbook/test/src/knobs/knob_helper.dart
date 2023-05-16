import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/knobs/knobs_notifier.dart';
import 'package:widgetbook/src/state/state.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

typedef WidgetBuilder = Widget Function(BuildContext context);

extension KnobHelper on WidgetTester {
  Future<void> pumpWithKnob(WidgetBuilder builder) async {
    final knobsNotifier = KnobsNotifier();

    return pumpWidget(
      ChangeNotifierProvider.value(
        value: knobsNotifier,
        child: WidgetbookScope(
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
                return Column(
                  children: [
                    builder(context),
                    ...knobsNotifier.all().map(
                          (knob) => Material(
                            child: KnobProperty(
                              name: knob.label,
                              description: knob.description,
                              value: knob.value,
                              isNullable: knob.isNullable,
                              changedNullable: (isEnabled) {
                                final notifier = context.read<KnobsNotifier>();
                                notifier.updateNullability(
                                    knob.label, !isEnabled);
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
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/workbench/use_case_builder.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

void main() {
  group(
    '$UseCaseBuilder',
    () {
      testWidgets(
        'update stateless widget',
        (tester) async {
          await tester.pumpKnob(
            (context) => Text(context.knobs.boolean(label: 'Foo').toString()),
          );
          await tester.pumpAndSettle();
          expect(find.text('false'), findsOneWidget);

          await tester.findAndTap(find.byType(Switch));
          expect(find.text('true'), findsOneWidget);
        },
      );

      testWidgets(
        'update stateful widget with create pattern',
        (tester) async {
          await tester.pumpKnob(
            (_) => _StatefulText(
              create: (ctx) => ctx.knobs.boolean(label: 'Foo').toString(),
            ),
          );
          await tester.pumpAndSettle();
          expect(find.text('false'), findsOneWidget);

          await tester.findAndTap(find.byType(Switch));
          expect(find.text('true'), findsOneWidget);
        },
      );
    },
  );
}

class _StatefulText extends StatefulWidget {
  const _StatefulText({required this.create});

  final String Function(BuildContext) create;

  @override
  State<_StatefulText> createState() => __StatefulTextState();
}

class __StatefulTextState extends State<_StatefulText> {
  String? data;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (data == null) {
      // mimics `package:provider` behavior
      data = widget.create(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(data ?? '');
  }
}

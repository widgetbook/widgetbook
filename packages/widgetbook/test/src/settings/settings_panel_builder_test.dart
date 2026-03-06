import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/settings/settings_panel_builder.dart';

void main() {
  testWidgets('Garde le contenu en vie', (tester) async {
    final controller = PageController();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PageView(
            controller: controller,
            children: [
              SettingsPanelBuilder(
                builder: (context) => const _TestWidget(),
              ),
              const Text('Autre Page'),
            ],
          ),
        ),
      ),
    );

    expect(find.text('0'), findsOneWidget);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();
    expect(find.text('1'), findsOneWidget);

    // Go to next page, actual widget is out of screen
    controller.jumpToPage(1);
    await tester.pumpAndSettle();

    expect(find.text('1'), findsNothing);

    // Go back
    controller.jumpToPage(0);
    await tester.pumpAndSettle();

    expect(find.text('1'), findsOneWidget);
  });
}

class _TestWidget extends StatefulWidget {
  const _TestWidget();

  @override
  State<_TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<_TestWidget> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(count.toString()),
        ElevatedButton(
          onPressed: () => setState(() => count++),
          child: const Text('+'),
        ),
      ],
    );
  }
}

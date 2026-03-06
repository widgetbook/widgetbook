import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/fields/field_builder.dart';

void main() {
  testWidgets('renders widget returned by builder', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: FieldBuilder<int>(
          group: 'group',
          value: 1,
          builder: (_) => const Text('Field'),
        ),
      ),
    );

    expect(find.text('Field'), findsOneWidget);
  });

  testWidgets('does not rebuild when value and group are unchanged', (
    tester,
  ) async {
    var buildCount = 0;

    Widget buildApp() {
      return MaterialApp(
        home: FieldBuilder<int>(
          group: 'group',
          value: 1,
          builder: (_) {
            buildCount++;
            return const Text('Field');
          },
        ),
      );
    }

    await tester.pumpWidget(buildApp());
    expect(buildCount, 1);

    await tester.pumpWidget(buildApp());
    expect(buildCount, 1);
  });

  testWidgets('rebuilds when value changes', (tester) async {
    var buildCount = 0;
    var value = 1;

    Widget buildApp() {
      return MaterialApp(
        home: FieldBuilder<int>(
          group: 'group',
          value: value,
          builder: (_) {
            buildCount++;
            return const Text('Field');
          },
        ),
      );
    }

    await tester.pumpWidget(buildApp());
    expect(buildCount, 1);

    value = 2;
    await tester.pumpWidget(buildApp());
    expect(buildCount, 2);
  });

  testWidgets('rebuilds when group changes', (tester) async {
    var buildCount = 0;
    var group = 'group';

    Widget buildApp() {
      return MaterialApp(
        home: FieldBuilder<int>(
          group: group,
          value: 1,
          builder: (_) {
            buildCount++;
            return const Text('Field');
          },
        ),
      );
    }

    await tester.pumpWidget(buildApp());
    expect(buildCount, 1);

    group = 'group_2';
    await tester.pumpWidget(buildApp());
    expect(buildCount, 2);
  });

  testWidgets('rebuilds when dependencies change', (tester) async {
    var buildCount = 0;

    Widget buildApp(ThemeData theme) {
      return Theme(
        data: theme,
        child: FieldBuilder<int>(
          group: 'group',
          value: 1,
          builder: (context) {
            Theme.of(context);
            buildCount++;
            return const SizedBox();
          },
        ),
      );
    }

    await tester.pumpWidget(buildApp(ThemeData.light()));
    await tester.pumpAndSettle();
    expect(buildCount, 1);

    await tester.pumpWidget(buildApp(ThemeData.dark()));
    await tester.pumpAndSettle();
    expect(buildCount, 2);
  });
}

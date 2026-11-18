import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/test/semantics/semantics_tree_serializer.dart';

void main() {
  testWidgets('serializes nodes in the widgetbook format', (tester) async {
    final handle = tester.ensureSemantics();
    const key = Key('box');

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
          child: Semantics(
            key: key,
            container: true,
            label: 'Box',
            child: const SizedBox.square(dimension: 10),
          ),
        ),
      ),
    );

    final json = SemanticsTreeSerializer.toJson(
      tester.getSemantics(find.byKey(key)),
    );

    expect(json['label'], 'Box');
    expect(json['rect'], [0.0, 0.0, 10.0, 10.0]);
    expect(json, isNot(contains('flags')));

    handle.dispose();
  });
}

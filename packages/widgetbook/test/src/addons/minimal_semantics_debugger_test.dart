import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/addons/semantics_addon/minimal_semantics_debugger.dart';

void main() {
  final painter = SemanticsDebuggerPainter(
    PipelineOwner(),
    0,
    1.0,
    const TextStyle(),
    'root',
  );

  group('$MinimalSemanticsDebugger', () {
    test(
      'given a flag SemanticsFlag.isSelected = true and a tap callback, '
      'then [getMessage] can parse the value',
      () {
        final node = SemanticsNode();
        final config = SemanticsConfiguration();

        config.isSelected = true;
        config.onTap = () {};
        node.updateWith(config: config);

        final message = painter.getMessage(node);
        expect(message, 'selected');
      },
    );

    test(
      'given a flag SemanticsFlag.isSelected = true without a tap callback, '
      'then [getMessage] can parse the value',
      () {
        final node = SemanticsNode();
        final config = SemanticsConfiguration();

        config.isSelected = true;
        node.updateWith(config: config);

        final message = painter.getMessage(node);
        expect(message, 'selected; disabled');
      },
    );

    test(
      'given a flag SemanticsFlag.isSelected = false and a tap callback, '
      'then [getMessage] can parse the value',
      () {
        final node = SemanticsNode();
        final config = SemanticsConfiguration();

        config.isSelected = false;
        config.onTap = () {};
        node.updateWith(config: config);

        final message = painter.getMessage(node);
        expect(message, 'unselected');
      },
    );

    test(
      'given a flag SemanticsFlag.isSelected = false without a tap callback, '
      'then [getMessage] can parse the value',
      () {
        final node = SemanticsNode();
        final config = SemanticsConfiguration();

        config.isSelected = false;
        node.updateWith(config: config);

        final message = painter.getMessage(node);
        expect(message, 'unselected; disabled');
      },
    );
  });
}

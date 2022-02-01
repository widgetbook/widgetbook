import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/mouse_tool/tool_provider.dart';
import 'package:widgetbook/src/mouse_tool/tool_state.dart';

void main() {
  group(
    '$ToolProvider',
    () {
      test(
        'returns $SelectionMode of ${SelectionMode.normal}',
        () {
          final provider = ToolProvider();
          expect(
            provider.state,
            equals(
              ToolState(mode: SelectionMode.normal),
            ),
          );
        },
      );

      test(
        'moveTool sets $SelectionMode to ${SelectionMode.move}',
        () {
          final provider = ToolProvider()..moveTool();
          expect(
            provider.state,
            equals(
              ToolState(mode: SelectionMode.move),
            ),
          );
        },
      );

      test(
        'moveTool sets $SelectionMode to ${SelectionMode.normal}',
        () {
          final provider = ToolProvider(
            state: ToolState(
              mode: SelectionMode.move,
            ),
          )..selecionTool();
          expect(
            provider.state,
            equals(
              ToolState(mode: SelectionMode.normal),
            ),
          );
        },
      );
    },
  );
}

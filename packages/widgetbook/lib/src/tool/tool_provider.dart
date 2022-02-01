import 'package:widgetbook/src/state_change_notifier.dart';
import 'package:widgetbook/src/tool/tool_state.dart';

class ToolProvider extends StateChangeNotifier<ToolState> {
  ToolProvider()
      : super(
          state: ToolState(),
        );

  void moveTool() {
    state = ToolState(mode: SelectionMode.move);
  }

  void selecionTool() {
    state = ToolState(mode: SelectionMode.normal);
  }
}

import 'package:widgetbook/src/mouse_tool/tool_state.dart';
import 'package:widgetbook/src/state_change_notifier.dart';

class ToolProvider extends StateChangeNotifier<ToolState> {
  ToolProvider({
    ToolState? state,
  }) : super(
          state: state ?? ToolState(),
        );

  void moveTool() {
    state = ToolState(mode: SelectionMode.move);
  }

  void selecionTool() {
    state = ToolState(mode: SelectionMode.normal);
  }
}

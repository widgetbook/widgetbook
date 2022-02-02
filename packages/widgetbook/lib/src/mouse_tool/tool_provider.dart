import 'package:widgetbook/src/mouse_tool/tool_state.dart';
import 'package:widgetbook/src/state_change_notifier.dart';

/// [ToolProvider] defines a bunch of mouse related tools.
///
/// For instance:
/// - Mouse for selecting and clicking
/// - Mouse for moving and zooming a previewed device.
class ToolProvider extends StateChangeNotifier<ToolState> {
  ToolProvider({
    ToolState? state,
  }) : super(
          state: state ?? ToolState(),
        );

  /// Activates the mode for moving and zooming a device
  void moveTool() {
    state = ToolState(mode: SelectionMode.move);
  }

  /// Activates the mode for interacting with a widget and device
  ///
  /// This mode is required for scrolling within a widget that contains e.g. a
  /// ScrollViewer.
  void selecionTool() {
    state = ToolState(mode: SelectionMode.normal);
  }
}

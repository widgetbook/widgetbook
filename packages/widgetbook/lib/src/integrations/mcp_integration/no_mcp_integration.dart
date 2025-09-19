import '../../../widgetbook.dart';

class McpIntegration extends WidgetbookIntegration {
  @override
  Future<void> onInit(WidgetbookState state) async {
    super.onInit(state);

    print('MCP Integration is not supported on this platform.');
  }
}

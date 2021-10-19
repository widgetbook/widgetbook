import 'package:widgetbook_models/widgetbook_models.dart';

class WidgetbookApp {
  final List<Device> devices;

  /// The name of the widgetbook.
  /// This information will be displayed at the top left corner in the UI.
  final String name;

  const WidgetbookApp({
    required this.name,
    this.devices = const <Device>[],
  });
}

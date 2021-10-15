import 'package:widgetbook_annotation/src/replace_soon.dart';

class WidgetbookStory {
  final String name;
  final Type type;

  const WidgetbookStory({
    required this.name,
    required this.type,
  });
}

class WidgetbookTheme {
  final bool isDarkTheme;

  const WidgetbookTheme.dark() : isDarkTheme = true;
  const WidgetbookTheme.light() : isDarkTheme = false;
}

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

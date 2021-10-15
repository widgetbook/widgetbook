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

  const WidgetbookApp({
    required this.devices,
  });
}

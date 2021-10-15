import 'package:widgetbook_generator/models/widgetbook_theme_data.dart';

String generateWidgetbook({
  required String name,
  WidgetbookThemeData? lightTheme,
  WidgetbookThemeData? darkTheme,
}) {
  return '''
class HotReload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Widgetbook(
      appInfo: ${generateAppInfo(name: name)},
      lightTheme: ${generateThemeDataValue(lightTheme)},
      darkTheme: ${generateThemeDataValue(darkTheme)},
    );
  }
}
''';
}

String generateAppInfo({
  required String name,
}) {
  return "AppInfo(name: '$name')";
}

String generateThemeDataValue(WidgetbookThemeData? themeData) {
  return themeData == null ? 'null' : '${themeData.name}()';
}

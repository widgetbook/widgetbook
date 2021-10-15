import 'package:widgetbook_generator/models/widgetbook_theme_data.dart';

String generateWidgetbook({
  WidgetbookThemeData? lightTheme,
  WidgetbookThemeData? darkTheme,
}) {
  return '''
class HotReload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Widgetbook(
      lightTheme: ${generateThemeDataValue(lightTheme)},
      darkTheme: ${generateThemeDataValue(darkTheme)},
    );
  }
}
''';
}

String generateThemeDataValue(WidgetbookThemeData? themeData) {
  return themeData == null ? 'null' : '${themeData.name}()';
}

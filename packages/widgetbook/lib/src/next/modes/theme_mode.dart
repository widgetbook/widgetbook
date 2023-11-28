import '../../addons/addons.dart';
import 'mode.dart';

class ThemeMode<T> extends ThemeAddon<T> with Mode<WidgetbookTheme<T>> {
  ThemeMode({
    required Map<String, T> themes,
    T? initialTheme,
    required super.themeBuilder,
  }) : super(
          themes: [
            for (final entry in themes.entries)
              WidgetbookTheme<T>(
                name: entry.key,
                data: entry.value,
              ),
          ],
          initialTheme: !themes.containsValue(initialTheme)
              ? null
              : WidgetbookTheme<T>(
                  name: themes.entries
                      .firstWhere((entry) => entry.value == initialTheme)
                      .key,
                  data: initialTheme!,
                ),
        );
}

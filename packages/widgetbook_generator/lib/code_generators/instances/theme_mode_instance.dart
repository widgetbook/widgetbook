import 'package:widgetbook_generator/code_generators/instances/base_instance.dart';

/// Implements a material ThemeMode instance
/// TODO delete this?
class ThemeModeInstance extends BaseInstance {
  /// Creates a new instance of [ThemeModeInstance]
  const ThemeModeInstance({
    required this.name,
  });

  final String name;

  @override
  String toCode() => 'ThemeMode.$name';
}

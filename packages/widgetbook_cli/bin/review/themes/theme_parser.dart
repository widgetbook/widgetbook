import 'package:file/local.dart';

import '../../parsers/generator_parser.dart';
import 'models/theme_data.dart';
import 'models/widgetbook_theme_data.dart';

class ThemeParser extends GeneratorParser<ThemeData> {
  ThemeParser({
    required super.projectPath,
    super.fileSystem = const LocalFileSystem(),
  });

  @override
  Future<List<ThemeData>> parse() async {
    final files = getFilesFromGeneratedFolder(
      fileExtension: '.theme.widgetbook.json',
    );
    final widgetbookThemes = getItemsFromFiles(
      files,
      fromJson: WidgetbookThemeData.fromJson,
    );

    return widgetbookThemes.map((e) => ThemeData(name: e.themeName)).toList();
  }
}

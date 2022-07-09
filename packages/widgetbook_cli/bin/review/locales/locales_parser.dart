import 'package:file/local.dart';

import '../../parsers/generator_parser.dart';
import 'models/locale_data.dart';
import 'models/widgetbook_locale_data.dart';

class LocaleParser extends GeneratorParser<LocaleData> {
  LocaleParser({
    required super.projectPath,
    super.fileSystem = const LocalFileSystem(),
  });

  @override
  Future<List<LocaleData>> parse() async {
    final files = getFilesFromGeneratedFolder(
      fileExtension: '.locales.widgetbook.json',
    );
    final widgetbookLocales = getItemsFromFiles(
      files,
      fromJson: WidgetbookLocaleData.fromJson,
    );

    if (widgetbookLocales.length == 1) {
      final widgetbookLocaleData = widgetbookLocales.first;

      return widgetbookLocaleData.locales
          .map((e) => LocaleData(name: e))
          .toList();
    } else {
      // If no locale is defined, return the default
      // If more than one [WidgetbookLocaleData] is defined, something is wrong
      // Therefore, we just default to 'en' as well.
      return [
        LocaleData(name: 'en'),
      ];
    }
  }
}

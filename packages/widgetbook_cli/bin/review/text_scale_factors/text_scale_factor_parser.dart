import 'package:file/local.dart';

import '../../parsers/generator_parser.dart';
import 'models/text_scale_factor_data.dart';

class TextScaleFactorParser extends GeneratorParser<TextScaleFactorData> {
  TextScaleFactorParser({
    required super.projectPath,
    super.fileSystem = const LocalFileSystem(),
  });

  @override
  Future<List<TextScaleFactorData>> parse() async {
    final files = getFilesFromGeneratedFolder(
      fileExtension: '.textscalefactors.widgetbook.json',
    );
    final textScaleFactors = getItemsFromFiles(
      files,
      fromJson: TextScaleFactorData.fromJson,
    ).toList();

    if (textScaleFactors.isNotEmpty) {
      return textScaleFactors;
    }

    return [
      TextScaleFactorData(value: 1),
    ];
  }
}

import 'dart:async';

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

/// Builder for the .json file which contains the necessary information to
/// generate code for Widgetbook. The information is saved as a .json file
/// to be consumed by the WidgetbookGenerator
class JsonBuilder extends Builder {
  /// Create a new instance of a [JsonBuilder] based on the generator.
  JsonBuilder(
    this.generator, {
    required this.formatOutput,
    required this.generatedExtension,
  });

  /// The generator resolving the specific annotation and returning the
  /// information written to the .json file.
  final Generator generator;

  /// A function that creates valid .json files from the information provided
  /// by the generator.
  final String Function(String output) formatOutput;

  /// The extension of the file.
  /// Must end on .json but might contain additional 'domains'
  /// for instance: .story.json
  final String generatedExtension;

  @override
  Map<String, List<String>> get buildExtensions => {
        '.dart': [generatedExtension],
      };

  @override
  Future<void> build(BuildStep buildStep) async {
    final resolver = buildStep.resolver;
    if (!await resolver.isLibrary(buildStep.inputId)) return;

    final library = LibraryReader(await buildStep.inputLibrary);
    final output = await generator.generate(library, buildStep);

    if (output == null || output.isEmpty) return;

    final outputId = buildStep.inputId.changeExtension(generatedExtension);
    final formattedOutput = formatOutput(output.trim());

    return buildStep.writeAsString(
      outputId,
      formattedOutput,
    );
  }
}

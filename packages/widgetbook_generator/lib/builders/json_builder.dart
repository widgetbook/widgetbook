// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:widgetbook_generator/models/generated_output.dart';

/// Builder for the .json file which contains the necessary information to
/// generate code for Widgetbook. The information is saved as a .json file
/// to be consumed by the WidgetbookGenerator
class JsonLibraryBuilder extends Builder {
  /// Create a new instance of a [JsonLibraryBuilder] based on the generator.
  JsonLibraryBuilder(
    this.generator, {
    required this.formatOutput,
    required this.generatedExtension,
  });

  /// The generator resolving the specific annotation and returning the
  /// information written to the .json file.
  final Generator generator;

  /// A function that creates valid .json files from the information provided
  /// by the generator.
  final String Function(String) formatOutput;

  /// The extension of the file.
  /// Must end on .json but might contain additional 'domains'
  /// for instance: .story.json
  final String generatedExtension;

  @override
  Future<void> build(BuildStep buildStep) async {
    final resolver = buildStep.resolver;
    if (!await resolver.isLibrary(buildStep.inputId)) return;
    final lib = await buildStep.inputLibrary;
    await _generateForLibrary(lib, buildStep);
  }

  Future<void> _generateForLibrary(
    LibraryElement library,
    BuildStep buildStep,
  ) async {
    final generatedOutputs =
        await _generate(library, generator, buildStep).toList();

    if (generatedOutputs.isEmpty) return;
    final outputId = buildStep.inputId.changeExtension(generatedExtension);

    final contentBuffer = StringBuffer();

    for (final item in generatedOutputs) {
      contentBuffer.writeln(item.output);
    }

    var genPartContent = contentBuffer.toString();
    genPartContent = formatOutput(genPartContent);

    return buildStep.writeAsString(outputId, genPartContent);
  }

  Stream<GeneratedOutput> _generate(
    LibraryElement library,
    Generator generator,
    BuildStep buildStep,
  ) async* {
    final libraryReader = LibraryReader(library);
    final gen = generator;
    try {
      var createdUnit = await gen.generate(libraryReader, buildStep);

      if (createdUnit == null) {
        return;
      }

      createdUnit = createdUnit.trim();
      if (createdUnit.isEmpty) {
        return;
      }

      yield GeneratedOutput(gen, createdUnit);
    } catch (e, stack) {
      log.severe('Error running $gen', e, stack);
      yield GeneratedOutput.fromError(gen, e, stack);
    }
  }

  @override
  Map<String, List<String>> get buildExtensions => {
        '.dart': [
          generatedExtension,
        ]
      };
}

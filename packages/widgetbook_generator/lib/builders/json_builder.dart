// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:widgetbook_generator/models/generated_output.dart';

class JsonLibraryBuilder extends Builder {
  JsonLibraryBuilder(
    this.generator, {
    required this.formatOutput,
    String generatedExtension = '.g.dart',
  }) : _generatedExtension = '.json.dart';

  final Generator generator;
  final String Function(String) formatOutput;
  final String _generatedExtension;

  @override
  Future build(BuildStep buildStep) async {
    final resolver = buildStep.resolver;
    if (!await resolver.isLibrary(buildStep.inputId)) return;
    final lib = await buildStep.inputLibrary;
    await _generateForLibrary(lib, buildStep);
  }

  Future _generateForLibrary(
    LibraryElement library,
    BuildStep buildStep,
  ) async {
    final generatedOutputs =
        await _generate(library, generator, buildStep).toList();

    if (generatedOutputs.isEmpty) return;
    final outputId = buildStep.inputId.changeExtension(_generatedExtension);

    final contentBuffer = StringBuffer();

    for (var item in generatedOutputs) {
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
          _generatedExtension,
        ]
      };
}

import 'dart:async';

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

/// A [Builder] that provides [LibraryReader] through the [buildForLibrary]
/// method. The [buildForLibrary] method is called for each library that is
/// processed by the builder.
abstract class BaseBuilder extends Builder {
  @override
  Future<void> build(BuildStep buildStep) async {
    final resolver = buildStep.resolver;
    final isLibrary = await resolver.isLibrary(buildStep.inputId);

    if (!isLibrary) return;

    final inputLibrary = await buildStep.inputLibrary;
    final library = LibraryReader(inputLibrary);

    return buildForLibrary(buildStep, library);
  }

  Future<void> buildForLibrary(
    BuildStep buildStep,
    LibraryReader library,
  );
}

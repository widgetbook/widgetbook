import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

/// Uses `source_gen` to format the generated code. The `formatOutput` method
/// from `LibraryBuilder` is using `DartFormatter` from `dart_style` package.
/// We are using this workaround to avoid having direct dependency
/// on `dart_style`; which can cause version conflicts, since we are
/// supporting wide range  of `analyzer` and `source_gen` packages.
String $format(String input) {
  final builder = LibraryBuilder(
    _StubGenerator(),
  );

  return builder.formatOutput(input);
}

class _StubGenerator extends Generator {
  @override
  String generate(LibraryReader library, BuildStep buildStep) {
    return '';
  }
}

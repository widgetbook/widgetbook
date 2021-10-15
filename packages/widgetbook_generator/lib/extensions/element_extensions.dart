import 'package:analyzer/dart/element/element.dart';

extension ElementExtensions on Element {
  String get importStatement {
    final source = librarySource ?? this.source!;

    return source.uri.toString();
  }

  List<String> get dependencies {
    return library!.importedLibraries
        .map((lib) => lib.location.toString())
        .toList();
  }
}

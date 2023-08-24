import 'package:analyzer/dart/element/element.dart';

/// Extension on Element to make extracting non trivial information simple
extension ElementExtensions on Element {
  /// Extracts the import statement from an Element
  String get importStatement {
    final source = librarySource ?? this.source!;

    return source.uri.toString();
  }
}

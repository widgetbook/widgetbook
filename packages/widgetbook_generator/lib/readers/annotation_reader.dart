import 'package:analyzer/dart/constant/value.dart';

/// A abstract represenation of a reader capable of parsing a [DartObject] into
/// an object of [ReadType]
abstract class AnnotationReader<ReadType> {
  /// Parses [object] into [ReadType]
  ReadType read(DartObject object);
}

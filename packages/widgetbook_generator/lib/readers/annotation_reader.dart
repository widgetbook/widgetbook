import 'package:analyzer/dart/constant/value.dart';

// TODO in theory it should be possible to read type fully automatically
// by defining some sort of reflection similar to equatable
// (aka reporting by string which properties exist)
abstract class AnnotationReader<ReadType> {
  ReadType read(DartObject object);
}

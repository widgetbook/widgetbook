import 'package:source_gen/source_gen.dart';

extension ConstantReaderExtension on ConstantReader {
  /// Reads [field] from the constant as another constant value.
  /// If the field is not present, returns `null`.
  ConstantReader? readOrNull(String field) {
    return read(field).isNull ? null : read(field);
  }

  /// Parses the constant value with the given [parser].
  T parse<T>(T Function(ConstantReader) parser) {
    return parser(this);
  }
}

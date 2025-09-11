import 'package:analyzer/dart/constant/value.dart';

extension DartObjectExtension on DartObject? {
  dynamic toPrimitiveValue() {
    final self = this;
    if (self == null) return null;

    if (self.toBoolValue() != null) return self.toBoolValue();
    if (self.toIntValue() != null) return self.toIntValue();
    if (self.toDoubleValue() != null) return self.toDoubleValue();
    if (self.toStringValue() != null) return self.toStringValue();

    throw Exception(
      'Unsupported DartObject type: ${self.type} is not a primitive type '
      '(null, bool, int, double, String)',
    );
  }
}

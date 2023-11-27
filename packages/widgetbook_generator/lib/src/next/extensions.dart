import 'package:analyzer/dart/element/type.dart';

extension DartTypeX on DartType {
  String get displayName {
    return getDisplayString(withNullability: false);
  }
}

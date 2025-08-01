import 'package:meta/meta.dart';

@internal
extension EnumByNameOrNull<T extends Enum> on Iterable<T> {
  /// Finds the enum value in this list with name [name].
  /// Returns `null` if no enum value with that name is found.
  T? byNameOrNull(String name) {
    try {
      return byName(name);
    } catch (e) {
      return null;
    }
  }
}

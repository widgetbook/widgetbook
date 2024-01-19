import 'generic_text.dart';

class GenericNum<T extends num> extends GenericText<T> {
  GenericNum({
    super.key,
    required super.value,
  });
}

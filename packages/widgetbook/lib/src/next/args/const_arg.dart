import '../../fields/fields.dart';
import 'arg.dart';

class ConstArg<T> extends Arg<T> {
  ConstArg(T value) : super(value: value);

  @override
  List<Field> get fields => [];

  @override
  ConstArg<T> init({required String name}) {
    return ConstArg(value);
  }

  @override
  T valueFromQueryGroup(Map<String, String> group) {
    return value;
  }
}

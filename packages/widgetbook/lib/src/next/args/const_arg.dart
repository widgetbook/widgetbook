import '../../fields/fields.dart';
import 'arg.dart';

class ConstArg<T> extends Arg<T> {
  ConstArg(super.value);

  @override
  List<Field> get fields => [];

  @override
  ConstArg<T> init({required String name}) => this;

  @override
  T valueFromQueryGroup(Map<String, String> group) => value;
}

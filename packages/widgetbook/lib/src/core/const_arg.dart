import '../fields/fields.dart';
import 'arg.dart';

class ConstArg<T> extends Arg<T> {
  const ConstArg(super.value);
  const ConstArg.empty() : super.empty();

  @override
  List<Field> get fields => [];

  @override
  ConstArg<T> init({required String name}) => this;

  @override
  T valueFromQueryGroup(Map<String, String> group) => value;

  Map<String, String> valueToQueryGroup(T value) => {};
}

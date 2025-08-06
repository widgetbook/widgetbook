// next version of Widgetbook doesn't have api docs yet
// ignore_for_file: public_member_api_docs
import '../../fields/fields.dart';
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
}

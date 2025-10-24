import '../fields/fields.dart';
import 'arg.dart';

class ConstArg<T> extends Arg<T> with NoFields {
  ConstArg(super.value);
}

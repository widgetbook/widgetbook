import 'package:meta/meta.dart';

import '../fields/fields.dart';
import 'arg.dart';

class ConstArg<T> extends Arg<T> with NoFields {
  ConstArg(super.value);

  @internal
  ConstArg.empty() : super.empty();
}

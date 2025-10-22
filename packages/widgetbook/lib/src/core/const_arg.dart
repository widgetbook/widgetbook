import 'package:flutter/widgets.dart';

import '../fields/fields.dart';
import 'arg.dart';

class ConstArg<T> extends Arg<T> with NoFields {
  ConstArg(super.value);

  @override
  T resolve(BuildContext context) => value;
}

import 'package:flutter/widgets.dart';

import '../fields/fields.dart';
import 'arg.dart';

class ConstArg<T> extends Arg<T> with NoFields {
  ConstArg(super.value);

  @override
  ConstArg<T> init({required String name}) => this;

  @override
  T resolve(BuildContext context) => value;
}

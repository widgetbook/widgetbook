import 'package:flutter/widgets.dart';

import '../fields/fields.dart';
import '../routing/routing.dart';
import 'arg.dart';

class ConstArg<T> extends Arg<T> {
  const ConstArg(super.value);

  @override
  List<Field> get fields => [];

  @override
  ConstArg<T> init({required String name}) => this;

  @override
  T valueFromQueryGroup(QueryGroup group) => value;

  QueryGroup valueToQueryGroup(T value) => {};

  @override
  T resolve(BuildContext context) => value;
}

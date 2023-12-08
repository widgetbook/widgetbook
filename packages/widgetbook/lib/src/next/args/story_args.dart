import 'package:flutter/widgets.dart';

import 'arg.dart';
import 'builder_arg.dart';
import 'const_arg.dart';

abstract class StoryArgs<T> {
  const StoryArgs();

  List<Arg> get list;

  List<Arg> get nonConstList {
    return list.where((arg) => arg is! ConstArg).toList();
  }

  /// Builds the story with this.
  /// If a [group] is given, the values are taken from the group.
  /// Otherwise, the default values are used.
  Widget build(BuildContext context, [Map<String, String>? group]);

  TArg resolve<TArg>(
    Arg<TArg> arg,
    BuildContext context, [
    Map<String, String>? group,
  ]) {
    if (arg is BuilderArg<TArg>) {
      return arg.resolve(context);
    } else if (group != null) {
      return arg.valueFromQueryGroup(group);
    } else {
      return arg.value;
    }
  }
}

import 'package:flutter/widgets.dart';

import 'arg.dart';
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
}

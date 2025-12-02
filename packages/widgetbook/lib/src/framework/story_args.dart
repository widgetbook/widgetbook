import 'arg.dart';
import 'const_arg.dart';

abstract class StoryArgs<T> {
  const StoryArgs();

  List<Arg?> get list;

  /// Non-nullable and non-const args
  List<Arg> get safeList {
    return list.nonNulls.where((arg) => arg is! ConstArg).toList();
  }
}

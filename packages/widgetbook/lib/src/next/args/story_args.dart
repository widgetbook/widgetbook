import 'arg.dart';
import 'const_arg.dart';

abstract class StoryArgs<T> {
  const StoryArgs();

  List<Arg> get list;

  List<Arg> get nonConstList {
    return list.where((arg) => arg is! ConstArg).toList();
  }
}

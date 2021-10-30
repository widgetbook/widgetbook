import 'package:meta/meta.dart';
import 'package:widgetbook_generator/code_generators/instances/base_instance.dart';

@immutable
class FunctionCallInstance extends BaseInstance {
  const FunctionCallInstance({
    required this.name,
  });

  final String name;

  @override
  String toCode() {
    return '$name()';
  }
}

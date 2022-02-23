import 'package:widgetbook_generator/code_generators/instances/base_instance.dart';

class Parameter extends BaseInstance {
  /// Creates a new instance of [Parameter].
  const Parameter({
    this.key,
    required this.instance,
  });

  final String? key;
  final BaseInstance instance;

  @override
  String toCode() {
    if (key != null) {
      return '$key: ${instance.toCode()}';
    }

    return instance.toCode();
  }
}

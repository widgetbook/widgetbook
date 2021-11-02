import 'package:test/expect.dart';
import 'package:test/test.dart';
import 'package:widgetbook_generator/code_generators/instances/instance.dart';

void testName(
  String name, {
  required Instance instance,
}) {
  test(".name returns '$name'", () {
    expect(
      instance.name,
      equals(name),
    );
  });
}

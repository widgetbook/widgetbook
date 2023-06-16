import 'package:test/test.dart';
import 'package:widgetbook_generator/instances/instance.dart';

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

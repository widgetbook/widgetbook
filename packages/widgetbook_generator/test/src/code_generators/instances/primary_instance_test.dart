import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:widgetbook_generator/code_generators/instances/primary_instance.dart';

class CustomType {}

class CustomTypePrimaryInstance extends PrimaryInstance<CustomType> {
  CustomTypePrimaryInstance()
      : super(
          value: CustomType(),
        );

  @override
  String toCode() {
    return value.toString();
  }
}

void main() {
  group(
    '$PrimaryInstance',
    () {
      final instance = CustomTypePrimaryInstance();

      test(
        '.value is of type $CustomType',
        () {
          expect(instance.value, isA<CustomType>());
        },
      );
    },
  );
}

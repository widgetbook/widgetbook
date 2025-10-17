import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import 'field_test.dart';

class MockFieldsComposable extends FieldsComposable<bool> with SingleFieldOnly {
  MockFieldsComposable()
    : super(
        name: '$MockFieldsComposable',
        initialValue: false,
      );

  @override
  Widget buildFields(BuildContext context) {
    return Container();
  }

  @override
  Field<bool> get field => MockField(
    name: 'mock_field',
    initialValue: true,
    toParam: (value) => value.toString(),
    toValue: (param) => param == 'true',
  );

  @override
  String get groupName => 'fields_group';
}

void main() {
  group(
    '$FieldsComposable',
    () {
      final composable = MockFieldsComposable();

      test(
        'given a name, '
        'when [slugify] is called, '
        'then it returns a slug-case of the name',
        () {
          final result = composable.slugify('Mock Field');
          expect(result, equals('mock-field'));
        },
      );

      test(
        'when [valueOf] is called, '
        'then it returns the value of the field from the group',
        () {
          final result = composable.valueOf<bool>(
            'mock_field',
            const QueryGroup({'mock_field': 'true'}),
          );
          ;
          expect(result, equals(true));
        },
      );
    },
  );
}

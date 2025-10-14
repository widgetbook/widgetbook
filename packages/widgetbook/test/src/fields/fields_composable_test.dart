import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import 'field_test.dart';

class MockFieldsComposable extends FieldsComposable<bool> {
  MockFieldsComposable() : super(name: '$MockFieldsComposable');

  @override
  Widget buildFields(BuildContext context) {
    return Container();
  }

  @override
  List<Field> get fields => [
    MockField(
      name: 'mock_field',
      initialValue: true,
      defaultValue: true,
      codec: FieldCodec(
        toParam: (value) => value.toString(),
        toValue: (param) => param == null ? null : param == 'true',
      ),
    ),
  ];

  @override
  String get groupName => 'fields_group';

  @override
  bool valueFromQueryGroup(QueryGroup group) {
    return valueOf('mock_field', group)!;
  }

  @override
  QueryGroup valueToQueryGroup(bool value) {
    return {'mock_field': paramOf('mock_field', value)};
  }
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
            {'mock_field': 'true'},
          );
          ;
          expect(result, equals(true));
        },
      );
    },
  );
}

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(MockBuildContext());
  });

  group(
    '$QueryGroup',
    () {
      const encodedGroup = '{first_field:false,second_field:2}';
      const decodedGroup = {
        'first_field': 'false',
        'second_field': '2',
      };

      test(
        'given a decoded query group with the field name, '
        'when [encodeQueryGroup] is called, '
        'then it returns the encoded value',
        () {
          final result = encodeQueryGroup(decodedGroup);
          expect(result, equals(encodedGroup));
        },
      );

      test(
        'given an encoded query group, '
        'when [decodeQueryGroup] is called, '
        'then it returns the decoded value',
        () {
          final result = decodeQueryGroup(encodedGroup);
          expect(result, equals(decodedGroup));
        },
      );

      test(
        'given a query group reserved characters, '
        'when [encodeQueryGroup] and [decodeQueryGroup] are successively called, '
        'then the decoded result is the same as before encoding',
        () {
          final group = {
            'Comma Field': 'Hello, World!',
            'Colon Field': '2022-01-01 00:00',
            'Special:Key': 'Special%Value',
          };

          final encodedGroup = encodeQueryGroup(group);
          final decodedGroup = decodeQueryGroup(encodedGroup);

          expect(decodedGroup, equals(group));
        },
      );

      test(
        'given a query group with url-encoded special characters, '
        'when [decodeQueryGroup] is called, '
        'then the result has decoded special characters',
        () {
          final specialChars = ', : ()';
          final encodedSpecialChars = Uri.encodeComponent(specialChars);
          final group = decodeQueryGroup(
            '{foo:bar$encodedSpecialChars}',
          );

          expect(group['foo'], equals('bar$specialChars'));
        },
      );

      test(
        'given a query group with non-ASCII (e.g. non-latin) characters, '
        'when [decodeQueryGroup] is called, '
        'then then decoding is skipped',
        () {
          final key = 'Тест field';
          final value = 'значение';
          final group = decodeQueryGroup('{$key:$value}');

          expect(group.keys.first, equals(key));
          expect(group.values.first, equals(value));
        },
      );

      test(
        'given a query group with non-encoded special characters (e.g. comma) '
        'and non-ASCII characters, '
        'when [decodeQueryGroup] is called, '
        'then an error is thrown',
        () {
          final key = 'Тест field';
          final value = 'значение,,foo';

          expect(
            () => decodeQueryGroup('{$key:$value}'),
            throwsA(isA<RangeError>()),
          );
        },
      );
    },
  );
}

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
      const decodedGroup = QueryGroup({
        'first_field': 'false',
        'second_field': '2',
      });

      test(
        'given a decoded query group with the field name, '
        'when [toParam] is called, '
        'then it returns the encoded value',
        () {
          final result = decodedGroup.toParam();
          expect(result, equals(encodedGroup));
        },
      );

      test(
        'given an encoded query group, '
        'when [QueryGroup.fromParam] is called, '
        'then it returns the decoded value',
        () {
          final result = QueryGroup.fromParam(encodedGroup);
          expect(result, equals(decodedGroup));
        },
      );

      test(
        'given a query group reserved characters, '
        'when [toParam] and [QueryGroup.fromParam] are successively called, '
        'then the decoded result is the same as before encoding',
        () {
          const group = QueryGroup({
            'Comma Field': 'Hello, World!',
            'Colon Field': '2022-01-01 00:00',
            'Special:Key': 'Special%Value',
          });

          final encodedGroup = group.toParam();
          final decodedGroup = QueryGroup.fromParam(encodedGroup);

          expect(decodedGroup, equals(group));
        },
      );

      test(
        'given a query group with url-encoded special characters, '
        'when [QueryGroup.fromParam] is called, '
        'then the result has decoded special characters',
        () {
          final specialChars = ', : ()';
          final encodedSpecialChars = Uri.encodeComponent(specialChars);
          final group = QueryGroup.fromParam(
            '{foo:bar$encodedSpecialChars}',
          );

          expect(group['foo'], equals('bar$specialChars'));
        },
      );

      test(
        'given a query group with non-ASCII (e.g. non-latin) characters, '
        'when [QueryGroup.fromParam] is called, '
        'then then decoding is skipped',
        () {
          final key = 'Тест field';
          final value = 'значение';
          final group = QueryGroup.fromParam('{$key:$value}');

          expect(group.fields.keys.first, equals(key));
          expect(group.fields.values.first, equals(value));
        },
      );

      test(
        'given a query group with non-encoded special characters (e.g. comma) '
        'and non-ASCII characters, '
        'when [QueryGroup.fromParam] is called, '
        'then the pairs split by the comma without a colon are skipped',
        () {
          final key = 'Тест field';
          final value = 'значение,,foo';

          final group = QueryGroup.fromParam('{$key:$value}');

          expect(group, equals(QueryGroup({key: 'значение'})));
        },
      );

      test(
        'given a query group with a single pair without a colon, '
        'when [QueryGroup.fromParam] is called, '
        'then it returns an empty group',
        () {
          expect(QueryGroup.fromParam('{value}'), equals(QueryGroup.empty));
        },
      );

      test(
        'given a query group with a mix of valid pairs and pairs without '
        'a colon, '
        'when [QueryGroup.fromParam] is called, '
        'then only the valid pairs are kept',
        () {
          expect(
            QueryGroup.fromParam('{a:1,b}'),
            equals(const QueryGroup({'a': '1'})),
          );
        },
      );

      test(
        'given a query group with a trailing comma, '
        'when [QueryGroup.fromParam] is called, '
        'then the empty pair is skipped',
        () {
          expect(
            QueryGroup.fromParam('{a:1,}'),
            equals(const QueryGroup({'a': '1'})),
          );
        },
      );

      test(
        'given a nullified query group with a pair without a colon, '
        'when [QueryGroup.fromParam] is called, '
        'then the pair is skipped and the group stays nullified',
        () {
          expect(
            QueryGroup.fromParam('??{a:1,b}'),
            equals(const QueryGroup({'a': '1'}, isNullified: true)),
          );
        },
      );

      test(
        'given a query group with a non-encoded colon in a value, '
        'when [QueryGroup.fromParam] is called, '
        'then the value is split on the first colon only',
        () {
          expect(
            QueryGroup.fromParam('{time:12:30}'),
            equals(const QueryGroup({'time': '12:30'})),
          );
        },
      );

      test(
        'given a query group with fields, '
        'when [hashCode] is read more than once, '
        'then it returns the same value',
        () {
          const group = QueryGroup({'value': '42'});

          expect(group.hashCode, equals(group.hashCode));
        },
      );

      test(
        'given two equal query groups, '
        'when their [hashCode]s are compared, '
        'then they are equal',
        () {
          const group = QueryGroup({'first': '1', 'second': '2'});
          final copy = QueryGroup.fromParam(group.toParam());

          expect(copy, equals(group));
          expect(copy.hashCode, equals(group.hashCode));
        },
      );

      test(
        'given two query groups that differ only in their field values, '
        'when their [hashCode]s are compared, '
        'then they are different',
        () {
          const group = QueryGroup({'value': '1'});
          const other = QueryGroup({'value': '2'});

          expect(other.hashCode, isNot(equals(group.hashCode)));
        },
      );
    },
  );
}

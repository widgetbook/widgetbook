import 'package:test/test.dart';

import 'package:widgetbook_cli/widgetbook_cli.dart';

void main() {
  group('$Reference', () {
    test('parse', () {
      final sha = '832e76a9899f560a90ffd62ae2ce83bbeff58f54';
      final refName = 'refs/heads/main';
      final ref = Reference.parse('$sha $refName');

      expect(ref.sha, equals(sha));
      expect(ref.fullName, equals(refName));
    });

    test('tag ref', () {
      final sha = '832e76a9899f560a90ffd62ae2ce83bbeff58f54';
      final refName = 'refs/tags/v1';
      final ref = Reference.parse('$sha $refName');

      expect(ref.isTag, equals(true));
      expect(ref.name, equals('v1'));
    });

    test('head ref', () {
      final sha = '832e76a9899f560a90ffd62ae2ce83bbeff58f54';
      final refName = 'refs/heads/main';
      final ref = Reference.parse('$sha $refName');

      expect(ref.isHead, equals(true));
      expect(ref.name, equals('main'));
    });

    test('remote ref', () {
      final sha = '832e76a9899f560a90ffd62ae2ce83bbeff58f54';
      final refName = 'refs/remotes/origin/main';
      final ref = Reference.parse('$sha $refName');

      expect(ref.isRemote, equals(true));
      expect(ref.name, equals('origin/main'));
    });
  });
}

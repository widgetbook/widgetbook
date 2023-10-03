import 'package:test/test.dart';

import '../../bin/git/bot.dart';
import '../../bin/git/commit_reference.dart';

void main() {
  test('valid sha', () {
    const good = 'bcd1284d805951a16e765cea5b2273a464ee2d86';
    expect(isValidSha(good), true);

    final bad = [
      '',
      ' ',
      '',
      ' bcd1284d805951a16e765cea5b2273a464ee2d86',
      'bbcd1284d805951a16e765cea5b2273a464ee2d86',
      'bbcd1284d8059 1a16e765cea5b2273a464ee2d86',
      'bbcd1284d8059z1a16e765cea5b2273a464ee2d86',
      'cd1284d805951a16e765cea5b2273a464ee2d86',
      // newline after
      '''bcd1284d805951a16e765cea5b2273a464ee2d86
''',

// newline before
      '''

bcd1284d805951a16e765cea5b2273a464ee2d86'''
    ];

    for (var v in bad) {
      expect(isValidSha(v), isFalse, reason: "'$v' should be bad");
      expect(() => requireArgumentValidSha1(v, 'v'), throwsArgumentError);
    }
  });

  test('parse show-ref output', () {
    final parsed = CommitReference.fromShowRefOutput(_showRefOutput);

    expect(parsed.length, 6);
    for (var t in parsed) {
      expect(t.sha, hasLength(40));
      expect(t.reference, isNot(isEmpty));
    }
  });
}

const _showRefOutput = '''ff1c31c454c4128a98dcd610d203820eeeb91923 HEAD
b430c0d6dffb95a0c90ca9eb2c13bf02cbc724ce refs/heads/fluid_demo
35d56f63bead3019f13e7a8c48cb55f5fb88feb8 refs/remotes/origin/husl
6dc275e3a498c0364d510b16f46fe9660eb554b0 refs/remotes/origin/master
eecbbc64a5a23275ad7c3e6a8585df662f193b70 refs/tags/v0.1.0
9f8592560f357a4d371bd3e77147e9f8369237c5 refs/tags/v0.1.0^{}
''';

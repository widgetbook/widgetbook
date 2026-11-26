import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/test.dart';
import 'package:widgetbook/widgetbook.dart';

/// A trivial widget; these stories are about what gets written, not about
/// what is rendered.
class _Box extends StatelessWidget {
  const _Box();

  @override
  Widget build(BuildContext context) => const SizedBox.square(dimension: 10);
}

class _BoxArgs extends StoryArgs<_Box> {
  const _BoxArgs();

  @override
  List<Arg?> get list => const [];
}

class _BoxStory extends Story<_Box, _BoxArgs> {
  _BoxStory({super.name, super.scenarios})
    : super(
        args: const _BoxArgs(),
        builder: (context, args) => const _Box(),
      );
}

/// Names of the scenarios whose `run` callback actually executed.
final executed = <String>{};

/// A component name no other test writes snapshots for.
const componentName = 'SnapshotsDefine';

/// Mirrors the define `testWidgetbook` reads. CI runs this file twice: once
/// as is, once with `--dart-define=WIDGETBOOK_SNAPSHOTS=false`.
const snapshots = bool.fromEnvironment(
  'WIDGETBOOK_SNAPSHOTS',
  defaultValue: true,
);

Future<void> main() async {
  final snapshotDir = Directory('build/.widgetbook/$componentName');
  if (snapshotDir.existsSync()) snapshotDir.deleteSync(recursive: true);

  final config = Config(
    components: [
      Component<_Box, _BoxArgs>(
        name: componentName,
        stories: [
          _BoxStory(
            name: 'Story',
            scenarios: [
              Scenario<_Box, _BoxArgs>(
                name: 'scenario',
                run: (tester, args) async => executed.add('scenario'),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  await testWidgetbook(config);

  // Runs after the scenario tests registered by `testWidgetbook` above.
  test('WIDGETBOOK_SNAPSHOTS=$snapshots runs the scenarios and '
      '${snapshots ? 'writes' : 'skips'} their snapshots', () {
    expect(executed, {'scenario'}, reason: 'the scenario should still run');
    expect(
      File('${snapshotDir.path}/Story/scenario.png').existsSync(),
      snapshots,
    );
    expect(
      File('${snapshotDir.path}/Story/scenario.json').existsSync(),
      snapshots,
    );
  });
}

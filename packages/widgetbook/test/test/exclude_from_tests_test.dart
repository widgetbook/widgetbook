import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/test.dart';
import 'package:widgetbook/widgetbook.dart';

/// A trivial widget; these stories are about which scenarios get executed,
/// not about what is rendered.
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
  _BoxStory({super.name, super.scenarios, super.excludeFromTests})
    : super(
        args: const _BoxArgs(),
        builder: (context, args) => const _Box(),
      );
}

/// Names of the scenarios whose `run` callback actually executed. A skipped
/// scenario never runs, so its name will be absent.
final executed = <String>{};

Scenario<_Box, _BoxArgs> _scenario(String name, {bool excluded = false}) {
  return Scenario<_Box, _BoxArgs>(
    name: name,
    excludeFromTests: excluded,
    run: (tester, args) async => executed.add(name),
  );
}

Future<void> main() async {
  final config = Config(
    components: [
      Component<_Box, _BoxArgs>(
        name: 'Included',
        stories: [
          _BoxStory(
            name: 'Story',
            scenarios: [
              _scenario('included scenario'),
              _scenario('excluded scenario', excluded: true),
            ],
          ),
        ],
      ),
      Component<_Box, _BoxArgs>(
        name: 'Excluded',
        stories: [
          _BoxStory(
            name: 'Story',
            excludeFromTests: true,
            scenarios: [_scenario('scenario in excluded story')],
          ),
        ],
      ),
    ],
  );

  await testWidgetbook(config);

  // Runs after the scenario tests registered by `testWidgetbook` above.
  test('excludeFromTests skips excluded scenarios and stories', () {
    expect(
      executed,
      {'included scenario'},
      reason:
          'only the non-excluded scenario of the non-excluded story should run',
    );
  });
}

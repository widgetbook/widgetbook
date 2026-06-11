import 'package:clock/clock.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/test.dart';
import 'package:widgetbook/widgetbook.dart';

/// Renders the current time.
///
/// Uses `clock.now()` from `package:clock`, which returns `DateTime.now()`
/// unless a fake clock is installed through the current `Zone` — calling
/// `DateTime.now()` directly could not be faked.
class _TimeText extends StatelessWidget {
  const _TimeText();

  @override
  Widget build(BuildContext context) {
    return Text('${clock.now()}');
  }
}

class _TimeTextArgs extends StoryArgs<_TimeText> {
  const _TimeTextArgs();

  @override
  List<Arg?> get list => const [];
}

class _TimeTextStory extends Story<_TimeText, _TimeTextArgs> {
  _TimeTextStory({super.scenarios})
    : super(
        name: 'Default',
        args: const _TimeTextArgs(),
        builder: (context, args) => const _TimeText(),
      );
}

void main() {
  group(
    '$ScenarioConfig.wrapper',
    () {
      final fakeTime = DateTime(2000);

      // The scenario's name and `run` callback become the description and
      // body of the `testWidgets` test that [testScenario] declares below;
      // pumping the story happens inside [testScenario] itself.
      final scenario = Scenario<_TimeText, _TimeTextArgs>(
        name:
            'given a wrapper with a fake clock, '
            'then the story renders the fake time',
        run: (tester, args) async {
          expect(
            find.text('$fakeTime'),
            findsOneWidget,
          );
        },
      );

      final config = Config(
        components: [
          Component<_TimeText, _TimeTextArgs>(
            name: 'TimeText',
            stories: [
              _TimeTextStory(scenarios: [scenario]),
            ],
          ),
        ],
        scenarioConfig: ScenarioConfig(
          wrapper: (tester, scenario, body) =>
              withClock(Clock.fixed(fakeTime), body),
        ),
      );

      testScenario(config, scenario);
    },
  );
}

import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/test.dart';
import 'package:widgetbook/widgetbook.dart';

/// A trivial widget; these stories are about the shared [ImageCache], not about
/// what gets rendered.
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
  _BoxStory({super.scenarios})
    : super(
        name: 'Default',
        args: const _BoxArgs(),
        builder: (context, args) => const _Box(),
      );
}

/// An [ImageStreamCompleter] that never completes, so it stays as a pending
/// entry in the [ImageCache] — a stand-in for an in-flight image load.
class _NeverCompleter extends ImageStreamCompleter {}

ImageCache get _imageCache => PaintingBinding.instance.imageCache;

Future<void> main() async {
  // Records what the *second* scenario sees in the shared cache at its start.
  // If the harness isolates scenarios, this must be empty despite the first
  // scenario polluting the cache.
  final pendingSeenBySecondScenario = <int>[];

  final polluting = Scenario<_Box, _BoxArgs>(
    name: 'first scenario pollutes the shared image cache',
    run: (tester, args) async {
      _imageCache.putIfAbsent('leaked', _NeverCompleter.new);
      expect(_imageCache.pendingImageCount, greaterThan(0));
    },
  );

  final observing = Scenario<_Box, _BoxArgs>(
    name: 'second scenario starts with a clean image cache',
    run: (tester, args) async {
      pendingSeenBySecondScenario.add(_imageCache.pendingImageCount);
    },
  );

  final config = Config(
    components: [
      Component<_Box, _BoxArgs>(
        name: 'Box',
        stories: [
          _BoxStory(scenarios: [polluting, observing]),
        ],
      ),
    ],
  );

  await testWidgetbook(config);

  // Runs after the two scenario tests registered by `testWidgetbook` above.
  test('testWidgetbook resets the image cache between scenarios', () {
    expect(
      pendingSeenBySecondScenario,
      [0],
      reason: 'the pending image leaked from the first scenario into the second',
    );
  });
}

import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';
import 'package:widgetbook/widgetbook.dart';

import 'video_demo.dart';

part 'video_demo.stories.g.dart';

final component = ComponentMeta(path: 'plugins');

const meta = Meta(VideoDemo.new);

final $Default = _Story(
  args: _Args(),
  scenarios: [
    _Scenario(
      name: 'Start',
      run: (tester, args) => _seekTo(tester, Duration.zero),
    ),
    _Scenario(
      name: 'Midpoint',
      run: (tester, args) =>
          _seekTo(tester, const Duration(milliseconds: 1500)),
    ),
  ],
);

/// Demonstrates the value of on-device `Scenario.run`: it receives a real
/// [WidgetTester], so it can reach into the running `video_player` controller
/// and drive it to a deterministic frame before the snapshot is taken.
Future<void> _seekTo(WidgetTester tester, Duration position) async {
  for (var i = 0; i < 40; i++) {
    await tester.pump(const Duration(milliseconds: 100));
    if (find.byType(VideoPlayer).evaluate().isNotEmpty) break;
  }

  final controller = tester
      .widget<VideoPlayer>(find.byType(VideoPlayer))
      .controller;
  await controller.seekTo(position);
  // While paused, iOS keeps the display link idle, so a seeked frame is not
  // pushed to the Flutter texture. Nudge playback to force the frame through,
  // then pause on it.
  await controller.play();
  await tester.pump(const Duration(milliseconds: 150));
  await controller.pause();
  await tester.pump(const Duration(milliseconds: 300));
}

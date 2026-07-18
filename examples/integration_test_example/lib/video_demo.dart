import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/// A component backed by the platform `video_player` plugin.
///
/// Renders a decoded video frame via a platform texture — content that never
/// appears under `flutter test`, only on a real device/simulator.
class VideoDemo extends StatefulWidget {
  const VideoDemo({super.key});

  @override
  State<VideoDemo> createState() => _VideoDemoState();
}

class _VideoDemoState extends State<VideoDemo> {
  late final VideoPlayerController controller;
  bool ready = false;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset('assets/sample.mp4');
    controller.initialize().then((_) {
      if (mounted) setState(() => ready = true);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Center(
        child: ready
            ? AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: VideoPlayer(controller),
              )
            : const SizedBox(
                width: 320,
                height: 180,
                child: Center(child: CircularProgressIndicator()),
              ),
      ),
    );
  }
}

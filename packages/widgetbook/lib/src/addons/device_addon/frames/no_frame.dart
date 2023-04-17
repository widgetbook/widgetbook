import 'package:flutter/widgets.dart';

import 'frame_builder.dart';

class NoFrameBuilder extends FrameBuilder {
  NoFrameBuilder({
    required super.setting,
  });

  @override
  Widget build(BuildContext context, Widget child) {
    return LayoutBuilder(
      builder: (context, constrains) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            size: Size(
              constrains.maxWidth,
              constrains.maxHeight,
            ),
          ),
          child: Builder(
            key: const Key('no_frame'),
            builder: (builder) {
              return child;
            },
          ),
        );
      },
    );
  }
}

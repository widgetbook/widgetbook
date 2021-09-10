import 'package:flutter/material.dart';
import 'package:widgetbook/src/widgets/story_render.dart';

import '../utils/utils.dart';
import 'controls_bar.dart';

class Editor extends StatelessWidget {
  const Editor({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const ControlsBar(),
        const SizedBox(
          height: 16,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: context.colorScheme.surface,
            ),
            child: const StoryRender(),
          ),
        ),
      ],
    );
  }
}

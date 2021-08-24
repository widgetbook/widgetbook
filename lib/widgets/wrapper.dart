import 'package:flutter/material.dart';
import 'package:widgetbook/widgets/story_render.dart';

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
        ControlsBar(),
        SizedBox(
          height: 16,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: context.colorScheme.surface,
            ),
            child: StoryRender(),
          ),
        ),
      ],
    );
  }
}

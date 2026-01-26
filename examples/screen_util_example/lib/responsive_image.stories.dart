import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

import 'responsive_image.dart';

part 'responsive_image.stories.g.dart';

const meta = Meta<ResponsiveImage>();

final $Default = _Story(
  name: 'Default',
  args: _Args(
    url: Arg.fixed(
      'https://images.nintendolife.com/bb503ef1f79ff/ash-and-pikachu.original.jpg',
    ),
  ),
);

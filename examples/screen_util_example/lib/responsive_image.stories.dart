import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

import 'responsive_image.dart';

part 'responsive_image.stories.book.dart';

const meta = Meta<ResponsiveImage>();

final $Default = ResponsiveImageStory(
  name: 'Default',
  args: ResponsiveImageArgs(
    url: Arg.fixed(
      'https://images.nintendolife.com/bb503ef1f79ff/ash-and-pikachu.original.jpg',
    ),
  ),
);

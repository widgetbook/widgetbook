import 'package:flutter/material.dart';

import 'package:widgetbook/widgetbook.dart';

part 'container.stories.book.dart';

final meta = Meta<Container>();

final $Green = ContainerStory(
  name: 'Green',
  args: ContainerArgs(
    color: const ColorArg(Colors.green),
  ),
);

final $Red = ContainerStory(
  name: 'Red',
  args: ContainerArgs(
    color: const ColorArg(Colors.red),
  ),
);

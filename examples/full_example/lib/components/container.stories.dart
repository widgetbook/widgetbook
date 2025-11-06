import 'package:flutter/material.dart';

import 'package:widgetbook/widgetbook.dart';

part 'container.stories.book.dart';

const meta = Meta<Container>();

final $Green = _Story(
  name: 'Green',
  args: _Args(
    color: ColorArg(Colors.green),
  ),
);

final $Red = _Story(
  name: 'Red',
  args: _Args(
    color: ColorArg(Colors.red),
  ),
);

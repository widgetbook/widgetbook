import 'package:flutter/material.dart';

import 'package:widgetbook/widgetbook.dart';

import 'custom_card.dart';

part 'custom_card.stories.book.dart';

const meta = Meta<CustomCard>();

final $Default = _Story(
  name: 'Default',
  args: _Args(
    child: Arg.fixed(
      const Text('This is a custom card'),
    ),
  ),
);

final $Background = _Story(
  name: 'Background',
  args: _Args(
    backgroundColor: Arg.fixed(Colors.green.shade100),
    child: Arg.fixed(
      const Text('This is a custom card with background color'),
    ),
  ),
);

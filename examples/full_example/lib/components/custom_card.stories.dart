import 'package:flutter/material.dart';

import 'package:widgetbook/widgetbook.dart';

import 'custom_card.dart';

part 'custom_card.stories.book.dart';

const meta = Meta<CustomCard>();

final $Default = CustomCardStory(
  name: 'Default',
  args: CustomCardArgs(
    child: Arg.fixed(
      const Text('This is a custom card'),
    ),
  ),
);

final $Background = CustomCardStory(
  name: 'Background',
  args: CustomCardArgs(
    backgroundColor: Arg.fixed(Colors.green.shade100),
    child: Arg.fixed(
      const Text('This is a custom card with background color'),
    ),
  ),
);

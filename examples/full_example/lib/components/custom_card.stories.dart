import 'package:flutter/material.dart';

import 'package:widgetbook/next.dart';

import 'custom_card.dart';

part 'custom_card.stories.book.dart';

final meta = Meta<CustomCard>();

final $Default = CustomCardStory(
  name: 'Default',
  args: CustomCardArgs(
    child: BuilderArg(
      (context) => const Text(
        'This is a custom card',
      ),
    ),
  ),
);

final $Background = CustomCardStory(
  name: 'Background',
  args: CustomCardArgs(
    backgroundColor: Arg.fixed(Colors.green.shade100),
    child: BuilderArg(
      (context) => const Text(
        'This is a custom card with background color',
      ),
    ),
  ),
);

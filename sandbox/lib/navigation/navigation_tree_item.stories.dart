import 'package:flutter/widgets.dart';
import 'package:widgetbook/next.dart';
import 'package:widgetbook/src/navigation/navigation.dart';

part 'navigation_tree_item.stories.book.dart';

final meta = Meta<NavigationTreeTile>();

final $Default = NavigationTreeTileStory(
  name: 'Default',
  args: NavigationTreeTileArgs(
    node: Arg.fixed(
      WidgetbookCategory(
        name: 'Category',
        children: [],
      ),
    ),
  ),
);

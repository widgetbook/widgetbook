import 'package:flutter/widgets.dart';
import 'package:widgetbook/next.dart';
import 'package:widgetbook/src/navigation/navigation.dart';

import 'root_data.dart';

part 'navigation_tree_node.stories.book.dart';

final meta = Meta<NavigationTreeNode>();

final $Default = NavigationTreeNodeStory(
  name: 'Default',
  args: NavigationTreeNodeArgs(
    node: Arg.fixed(root.children!.first),
  ),
);

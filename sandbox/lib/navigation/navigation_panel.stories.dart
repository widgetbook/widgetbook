import 'package:widgetbook/next.dart';
import 'package:widgetbook/src/navigation/navigation.dart';

import 'root_data.dart';

part 'navigation_panel.stories.book.dart';

final meta = Meta<NavigationPanel>();

final $Default = NavigationPanelStory(
  name: 'Default',
  args: NavigationPanelArgs(
    root: Arg.fixed(root),
  ),
);

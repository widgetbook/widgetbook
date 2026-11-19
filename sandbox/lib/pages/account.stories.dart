import 'package:material_ui/material_ui.dart';
import 'package:widgetbook/widgetbook.dart';

import 'example_page.dart';

part 'account.stories.g.dart';

const component = ComponentMeta(name: 'Account');

const meta = Meta(ExamplePage.new);

final _phone = [ViewportMode(IosViewports.iPhone13)];

final $Home = _Story(
  modes: _phone,
  args: _Args(title: StringArg('Home')),
);

final $Profile = _Story(
  modes: _phone,
  args: _Args(title: StringArg('Profile')),
);

final $Settings = _Story(
  modes: _phone,
  args: _Args(title: StringArg('Settings')),
);

import 'package:material_ui/material_ui.dart';
import 'package:widgetbook/widgetbook.dart';

import 'example_page.dart';

part 'auth.stories.g.dart';

const component = ComponentMeta(name: 'Auth');

const meta = Meta(ExamplePage.new);

final _phone = [ViewportMode(IosViewports.iPhone13)];

final $Welcome = _Story(
  modes: _phone,
  args: _Args(title: StringArg('Welcome')),
);

final $SignIn = _Story(
  modes: _phone,
  name: 'Sign In',
  args: _Args(title: StringArg('Sign In')),
);

final $SignUp = _Story(
  modes: _phone,
  name: 'Sign Up',
  args: _Args(title: StringArg('Sign Up')),
);

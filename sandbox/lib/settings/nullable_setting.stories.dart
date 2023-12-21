import 'package:flutter/widgets.dart';
import 'package:widgetbook/src/settings/nullable_setting.dart';
import 'package:widgetbook/widgetbook.dart';

part 'nullable_setting.stories.book.dart';

final meta = Meta<NullableSetting>();

final $Default = NullableSettingStory(
  name: 'Default',
  args: NullableSettingArgs(
    name: const StringArg('Knob'),
    child: Arg.fixed(
      const Placeholder(),
    ),
  ),
);

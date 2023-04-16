import 'package:flutter/material.dart';
import 'package:widgetbook_addon/widgetbook_addon.dart';
import 'package:widgetbook/src/addons/frame_addon/addons/no_frame/no_frame_setting.dart';

class NoFrameAddon extends WidgetbookAddOn<NoFrameSetting> {
  NoFrameAddon()
      : super(
          name: 'No Frame',
          setting: NoFrameSetting(),
        );

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

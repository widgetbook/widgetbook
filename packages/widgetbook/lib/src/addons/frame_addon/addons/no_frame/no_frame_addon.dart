import 'package:flutter/material.dart';
import 'package:widgetbook/src/addons/addon.dart';
import 'package:widgetbook/src/addons/frame_addon/addons/no_frame/no_frame_setting.dart';
import 'package:widgetbook/src/routing/router.dart';

class NoFrameAddon extends WidgetbookAddOn<NoFrameSetting> {
  NoFrameAddon()
      : super(
          name: 'No Frame',
          setting: NoFrameSetting(),
        );

  @override
  void updateQueryParameters(BuildContext context, NoFrameSetting value) {
    context.goTo(queryParams: value.toQueryParameter());
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

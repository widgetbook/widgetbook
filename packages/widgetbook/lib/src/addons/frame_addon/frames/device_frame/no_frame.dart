import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

class NoFrame extends Frame {
  NoFrame()
      : super(
          name: 'No Frame',
          addon: NoFrameAddon(),
        );

  @override
  Widget builder(BuildContext context, Widget child) {
    return Builder(
      key: const Key('no_frame'),
      builder: (builder) {
        return child;
      },
    );
  }
}

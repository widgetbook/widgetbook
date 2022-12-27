import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

class NoFrame extends Frame {
  NoFrame()
      : super(
          name: 'No Frame',
          addon: NoFrameAddon(),
          getDefaultQueryParameters: {},
        );

  @override
  Widget builder(BuildContext context, Widget child) {
    return LayoutBuilder(
      builder: (context, constrains) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            size: Size(
              constrains.maxWidth,
              constrains.maxHeight,
            ),
          ),
          child: Builder(
            key: const Key('no_frame'),
            builder: (builder) {
              return child;
            },
          ),
        );
      },
    );
  }
}

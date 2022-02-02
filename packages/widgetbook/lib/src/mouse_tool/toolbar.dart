import 'package:flutter/material.dart';
import 'package:widgetbook/src/mouse_tool/mouse_handle.dart';
import 'package:widgetbook/src/translate/translate_handle.dart';
import 'package:widgetbook/src/widgets/widgetbook_card.dart';
import 'package:widgetbook/src/zoom/zoom_handle.dart';

class Toolbar extends StatelessWidget {
  const Toolbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        MouseHandle(),
        SizedBox(
          height: 8,
        ),
        WidgetbookCard(child: ZoomHandle()),
        SizedBox(
          height: 8,
        ),
        WidgetbookCard(child: TranslateHandle()),
      ],
    );
  }
}

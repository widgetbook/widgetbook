import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

import 'pdf_demo.dart';

part 'pdf_demo.stories.g.dart';

final component = ComponentMeta(path: 'plugins');

const meta = Meta(PdfDemo.new);

final $Default = _Story(
  args: _Args(),
  scenarios: [
    _Scenario(name: 'Page 1', run: (tester, args) => _waitForRender(tester)),
  ],
);

/// `pdfrx` rasterizes the page asynchronously; `run` uses the [WidgetTester]
/// to pump frames until PDFium has painted before the snapshot is captured.
Future<void> _waitForRender(WidgetTester tester) async {
  for (var i = 0; i < 20; i++) {
    await tester.pump(const Duration(milliseconds: 200));
  }
}

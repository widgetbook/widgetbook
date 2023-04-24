import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.Theme(name: 'Dark', isDefault: true)
ThemeData darkTheme() => ThemeData.dark();

@widgetbook.Theme(name: 'Default', type: CustomPadding)
Widget customPaddingStory(BuildContext context) {
  return Container(
    color: Colors.green,
    child: CustomPadding(
      widget: Text('Test'),
    ),
  );
}

class CustomPadding extends StatelessWidget {
  const CustomPadding({
    Key? key,
    required this.widget,
  }) : super(key: key);
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: widget,
    );
  }
}

@widgetbook.App(name: 'Example App')
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: darkTheme(),
    );
  }
}

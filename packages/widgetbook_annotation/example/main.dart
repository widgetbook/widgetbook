import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@WidgetbookTheme(name: 'Dark', isDefault: true)
ThemeData darkTheme() => ThemeData.dark();

@WidgetbookUseCase(name: 'Default', type: CustomPadding)
Widget customPaddingStory(BuildContext context) {
  return Container(
    color: Colors.green,
    child: CustomPadding(
      widget: Text('Test'),
    ),
  );
}

class CustomPadding extends StatelessWidget {
  final Widget widget;
  const CustomPadding({
    Key? key,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: widget,
    );
  }
}

@WidgetbookApp(name: 'Example App')
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: darkTheme(),
    );
  }
}

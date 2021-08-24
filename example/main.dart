import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

class CustomWidget extends StatelessWidget {
  const CustomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Text('hello world'),
    );
  }
}

class Storybook extends StatelessWidget {
  const Storybook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgetbook(
      categories: [
        Category(
          name: 'widgets',
          widgets: [
            WidgetElement(
              name: '$CustomWidget',
              stories: [
                Story(
                  name: 'Default',
                  builder: (context) => CustomWidget(),
                ),
              ],
            )
          ],
        ),
      ],
      appInfo: AppInfo(
        name: 'Widgetbook Example',
      ),
    );
  }
}

void main() {
  runApp(Storybook());
}

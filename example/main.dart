import 'package:flutter/material.dart';
// TODO these are too many imports. An export file is required.
import 'package:widgetbook/flutter_firebook.dart';
import 'package:widgetbook/models/app_info.dart';
import 'package:widgetbook/models/organizers/category.dart';
import 'package:widgetbook/models/organizers/story.dart';
import 'package:widgetbook/models/organizers/widget_element.dart';

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

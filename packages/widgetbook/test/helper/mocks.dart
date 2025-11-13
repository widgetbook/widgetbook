import 'package:flutter/widgets.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook/widgetbook.dart';

class MockBuildContext extends Mock implements BuildContext {}

class MockWidgetbookState extends Mock implements WidgetbookState {}

class MockStoryArgs extends Mock implements StoryArgs<Widget> {}

class MockStory extends Mock implements Story<Widget, MockStoryArgs> {}

class MockConfig extends Mock implements Config {}

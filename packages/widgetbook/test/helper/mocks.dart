import 'package:flutter/widgets.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook/src/knobs/knobs.dart';
import 'package:widgetbook/src/state/state.dart';

class MockBuildContext extends Mock implements BuildContext {}

class MockWidgetbookState extends Mock implements WidgetbookState {}

class MockKnobsRegistry extends Mock implements KnobsRegistry {}

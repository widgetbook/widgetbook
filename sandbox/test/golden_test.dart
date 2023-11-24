import 'package:alchemist/alchemist.dart';
import 'package:sandbox/next/simple_text.stories.dart';
import 'package:widgetbook/next.dart';

void main() {
  goldenTest(
    '${SimpleTextComponent.name} renders correctly',
    fileName: SimpleTextComponent.name,
    builder: () => GoldenTestGroup(
      children: [
        SimpleTextScenario(
          name: 'Default',
          story: $SimpleText,
          args: const SimpleTextArgs(
            data: StringArg(
              name: 'data',
              value: 'Hello World',
            ),
          ),
        ),
      ],
    ),
  );
}

import 'package:alchemist/alchemist.dart';
import 'package:sandbox/next/simple_text.stories.dart';
import 'package:widgetbook/next.dart';

void main() {
  final name = SimpleTextComponent.metadata.type.toString();

  goldenTest(
    '$name renders correctly',
    fileName: name,
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

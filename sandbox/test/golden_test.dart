import 'package:alchemist/alchemist.dart';
import 'package:sandbox/next/types_table.stories.dart';

void main() {
  goldenTest(
    '${TypesTableComponent.name} renders correctly',
    fileName: TypesTableComponent.name,
    builder: () => GoldenTestGroup(
      children: [
        TypesTableScenario(
          name: 'Default',
          story: $Default,
        ),
      ],
    ),
  );
}

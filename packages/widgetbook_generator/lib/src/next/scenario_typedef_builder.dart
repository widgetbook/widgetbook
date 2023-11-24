import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';

class ScenarioTypedefBuilder {
  ScenarioTypedefBuilder(this.type);

  final DartType type;

  String get name {
    return type.getDisplayString(withNullability: false);
  }

  TypeDef build() {
    return TypeDef(
      (b) => b
        ..name = '${name}Scenario'
        ..definition = refer('WidgetbookScenario<$name>'),
    );
  }
}

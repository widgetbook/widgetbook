import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';

import 'extensions.dart';

class ScenarioTypedefBuilder {
  ScenarioTypedefBuilder(this.type);

  final DartType type;

  TypeDef build() {
    return TypeDef(
      (b) => b
        ..name = '${type.displayName}Scenario'
        ..definition = refer('WidgetbookScenario<${type.displayName}>'),
    );
  }
}

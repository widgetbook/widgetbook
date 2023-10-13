import 'package:widgetbook_generator/widgetbook_generator.dart';

/// A simple [UseCaseMetadata] that has default value for all fields.
class MockUseCaseMetadata extends UseCaseMetadata {
  MockUseCaseMetadata({
    super.functionName = 'defaultUseCase',
    super.designLink = null,
    super.name = 'Default',
    super.importUri = 'package:widgetbook/src/widgets/component.usecase.dart',
    super.filePath = 'lib/src/widgets/component.usecase.dart',
    super.pathInWidgetbook = 'widgets',
    String componentName = 'Component',
    String componentImportUri = 'package:widgetbook/src/widgets/component.dart',
    String componentFilePath = 'lib/src/widgets/component.dart',
  }) : super(
          component: ElementMetadata(
            name: componentName,
            importUri: componentImportUri,
            filePath: componentFilePath,
          ),
        );
}

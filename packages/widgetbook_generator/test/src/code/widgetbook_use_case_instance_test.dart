import 'package:test/test.dart';
import 'package:widgetbook_generator/widgetbook_generator.dart';

import '../../helpers/code.dart';
import '../../helpers/mock_use_case_metadata.dart';

void main() {
  group('$WidgetbookUseCaseInstance', () {
    test('single use case', () {
      final actual = WidgetbookUseCaseInstance(
        useCase: MockUseCaseMetadata(),
      );

      expectExpression(
        actual,
        '''
          WidgetbookUseCase(
            name: 'Default',
            builder: defaultUseCase,
          )
        ''',
      );
    });
  });
}

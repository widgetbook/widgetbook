import 'package:test/test.dart';
import 'package:widgetbook_generator/widgetbook_generator.dart';

import '../../helpers/mock_use_case_metadata.dart';

void main() {
  group('$UsageReport', () {
    final report = UsageReport.from(
      version: '3.x.x',
      project: 'test',
      projectId: 'yyyy',
      trackingId: 'xxxx',
      ownerUrl: null,
      useCases: [
        MockUseCaseMetadata(
          componentName: 'ComponentA',
          componentImportUri: 'package:ui_pkg_a/component_a.dart',
          name: 'UseCaseA1',
        ),
        MockUseCaseMetadata(
          componentName: 'ComponentA',
          componentImportUri: 'package:ui_pkg_a/component_a.dart',
          name: 'UseCaseA2',
        ),
        MockUseCaseMetadata(
          componentName: 'ComponentA',
          componentImportUri: 'package:ui_pkg_a/component_a.dart',
          name: 'UseCaseA3',
        ),
        MockUseCaseMetadata(
          componentName: 'ComponentB',
          componentImportUri: 'package:ui_pkg_b/component_a.dart',
          name: 'UseCaseB1',
        ),
        MockUseCaseMetadata(
          componentName: 'ComponentB',
          componentImportUri: 'package:ui_pkg_b/component_a.dart',
          name: 'UseCaseB2',
        ),
      ],
    );

    test('correct heat map', () {
      expect(
        report.heatMap,
        equals({
          3: 1,
          2: 1,
        }),
      );
    });

    test('correct components count', () {
      expect(
        report.componentsCount,
        equals(2),
      );
    });

    test('correct use cases count', () {
      expect(
        report.useCasesCount,
        equals(5),
      );
    });

    test('correct packages', () {
      expect(
        report.packages,
        equals({
          'ui_pkg_a',
          'ui_pkg_b',
        }),
      );
    });

    test('correct id', () {
      expect(
        report.id,
        equals('yyyy-C2-U5-P2-V3.x.x'),
      );
    });

    test('correct event', () {
      expect(
        report.toMixpanelEvent(
          isDebug: true,
          token: 'x',
        ),
        equals({
          'event': 'Generator Used (Debug)',
          'properties': {
            'token': 'x',
            'time': report.timestamp.millisecondsSinceEpoch ~/ 1000,
            'distinct_id': report.trackingId,
            '\$insert_id': report.id,
            'version': '3.x.x',
            'project': report.project,
            'project_id': report.projectId,
            'packages': report.packages.toList(),
            'components': 2,
            'use_cases': 5,
            'heat_map': {'3': 1, '2': 1},
            'owner_url': null,
          },
        }),
      );
    });
  });
}

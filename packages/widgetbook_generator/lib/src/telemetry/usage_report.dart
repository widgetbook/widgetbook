import 'package:collection/collection.dart';

import '../models/use_case_metadata.dart';

class UsageReport {
  UsageReport.from({
    required this.trackingId,
    required this.projectId,
    required this.project,
    required List<UseCaseMetadata> useCases,
    required this.version,
    required this.ownerUrl,
  }) {
    packages = useCases.map((e) => e.component.package).toSet();

    // Map between component name and the length of the use-cases
    final components = useCases.groupFoldBy<String, int>(
      (x) => x.component.name,
      (count, x) => count == null ? 1 : count + 1,
    );

    heatMap = components.values.fold(
      {},
      (map, length) => map
        ..update(
          length,
          (occurrence) => occurrence + 1,
          ifAbsent: () => 1,
        ),
    );
  }

  final String trackingId;
  final String projectId;
  final String project;
  final DateTime timestamp = DateTime.now();

  /// `widgetbook_generator` version
  final String version;

  /// URL to the owner's git account
  /// Example: https://github.com/widgetbook
  final String? ownerUrl;

  /// Unique set of components' packages.
  /// This helps identify different projects
  late final Set<String> packages;

  /// The key is the the length of a component's use cases, the value is the
  /// number of components with that many use cases.
  /// For example, if there are 3 components with 2 use cases each, the map
  /// will contain the entry 2: 3.
  late final Map<int, int> heatMap;

  int get componentsCount => heatMap.values.reduce(
    (total, count) => total + count,
  );

  int get useCasesCount => heatMap.entries.fold(
    0,
    (total, entry) => total + entry.key * entry.value,
  );

  /// Unique ID to identify the report
  String get id =>
      '$projectId'
      '-C$componentsCount'
      '-U$useCasesCount'
      '-P${packages.length}'
      '-V$version';

  Map<String, dynamic> toMixpanelEvent({
    required bool isDebug,
    required String token,
  }) {
    return {
      'event': 'Generator Used${isDebug ? ' (Debug)' : ''}',
      'properties': {
        'token': token,
        'time': timestamp.millisecondsSinceEpoch ~/ 1000,
        'distinct_id': trackingId,
        '\$insert_id': id,
        'version': version,
        'project': project,
        'project_id': projectId,
        'packages': packages.toList(),
        'components': componentsCount,
        'use_cases': useCasesCount,
        'heat_map': heatMap.map((key, value) => MapEntry('$key', value)),
        'owner_url': ownerUrl,
      },
    };
  }
}

import 'package:collection/collection.dart';

import '../models/use_case_metadata.dart';

class UsageReport {
  UsageReport.from({
    required this.trackingId,
    required this.project,
    required List<UseCaseMetadata> useCases,
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
  final String project;
  final DateTime timestamp = DateTime.now();
  final String version = '3.x.x';
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
  String get id => '$project'
      '-C$componentsCount'
      '-U$useCasesCount'
      '-P${packages.length}'
      '-V$version';

  Map<String, dynamic> toMixPanelEvent({
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
        'packages': packages.toList(),
        'components': componentsCount,
        'use_cases': useCasesCount,
        'heat_map': heatMap.map((key, value) => MapEntry('$key', value)),
      },
    };
  }
}

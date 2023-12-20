class UsageReport {
  UsageReport.from({
    required this.trackingId,
    required this.project,
    required this.version,
  });

  /// Unique ID for each user
  final String trackingId;

  // Current package name (probably `widgetbook_workspace` for SAM)
  final String project;

  final DateTime timestamp = DateTime.now();

  /// `widgetbook_generator` version
  final String version;

  /// Unique ID to identify the report
  String get id => '$project-V$version';

  Map<String, dynamic> toMixpanelEvent({
    required bool isDebug,
    required String token,
  }) {
    return {
      'event': 'SAM Used${isDebug ? ' (Debug)' : ''}',
      'properties': {
        'token': token,
        'time': timestamp.millisecondsSinceEpoch ~/ 1000,
        'distinct_id': trackingId,
        '\$insert_id': id,
        'version': version,
        'project': project,
      },
    };
  }
}

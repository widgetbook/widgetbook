class UsageReport {
  UsageReport.from({
    required this.trackingId,
    required this.projectId,
    required this.project,
    required this.version,
    required this.ownerUrl,
  }) {}

  /// Unique ID for each user
  final String trackingId;
  final String projectId;
  final String project;

  final DateTime timestamp = DateTime.now();

  /// `widgetbook` version
  final String version;

  /// URL to the owner's git account
  /// Example: https://github.com/widgetbook
  final String? ownerUrl;

  /// Unique ID to identify the report
  String get id => '$projectId-V$version';

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
        'project_id': projectId,
        'owner_url': ownerUrl,
      },
    };
  }
}

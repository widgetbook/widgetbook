class AppendSnapshotsResponse {
  const AppendSnapshotsResponse({
    required this.inserted,
  });

  final int inserted;

  // ignore: sort_constructors_first
  factory AppendSnapshotsResponse.fromJson(Map<String, dynamic> json) {
    return AppendSnapshotsResponse(
      inserted: json['inserted'] as int,
    );
  }
}

class CiArgs {
  const CiArgs({
    required this.vendor,
    this.actor,
    this.repository,
  });

  final String vendor;
  final String? actor;
  final String? repository;
}

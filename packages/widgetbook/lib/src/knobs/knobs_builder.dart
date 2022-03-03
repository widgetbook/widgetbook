abstract class KnobsBuilder {
  /// {@macro knobs_builder}
  const KnobsBuilder();

  /// Creates checkbox with [label], [description] and [initialValue] value.
  bool boolean({
    required String label,
    String? description,
    bool initialValue = false,
  });

  bool? nullableBoolean({
    required String label,
    String? description,
    bool? initialValue = false,
  });

  String text({
    required String label,
    String? description,
    String initialValue,
  });
}

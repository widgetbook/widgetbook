abstract class KnobsBuilder {
  /// {@macro knobs_builder}
  const KnobsBuilder();

  /// Creates checkbox with [label], [description] and [initial] value.
  bool boolean({
    required String label,
    String? description,
    bool initial = false,
  });
  /// Creates text input field with [label], [description] and [initial] value.
}

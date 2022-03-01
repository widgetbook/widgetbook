abstract class KnobsBuilder {
  /// {@macro knobs_builder}
  const KnobsBuilder();

  /// Creates checkbox with [label], [description] and [initialValue] value.
  bool boolean({
    required String label,
    String? description,
    bool initialValue = false,
  });
  /// Creates text input field with [label], [description] and [initial] value.
}

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

  String? nullableText({
    required String label,
    String? description,
    String? initialValue,
  });

  double slider({
    required String label,
    String? description,
    required double initialValue,
    double max,
    double min,
    int? divisions,
  });

  num number({
    required String label,
    String? description,
    num initialValue,
  });
}

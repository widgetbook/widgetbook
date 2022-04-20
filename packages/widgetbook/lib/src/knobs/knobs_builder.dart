import 'package:widgetbook/src/knobs/knobs.dart';

abstract class KnobsBuilder {
  const KnobsBuilder();

  /// Creates a checkbox that can be toggled on and off
  bool boolean({
    required String label,
    String? description,
    bool initialValue = false,
  });

  /// Creates a checkbox that can be toggled on and off and optionally hold a
  // null value
  bool? nullableBoolean({
    required String label,
    String? description,
    bool? initialValue = false,
  });

  /// Creates a textfield that can be typed in
  String text({
    required String label,
    String? description,
    String initialValue,
  });

  /// Creates a textfield that can be typed in and optionally hold a
  // null value
  String? nullableText({
    required String label,
    String? description,
    String? initialValue,
  });

  /// Creates a slider that can be slid to specific double values. You can use
  // the `num.toInt()` function to make this into an integer
  double slider({
    required String label,
    String? description,
    double initialValue,
    double? max,
    double? min,
    int? divisions,
  });

  /// Creates a slider that can be slid to specific double values. You can use
  /// the `num?.toInt()` function to make this into an integer.
  /// Can optionally hold a null value
  double? nullableSlider({
    required String label,
    String? description,
    double initialValue,
    double? max,
    double? min,
    int? divisions,
  });

  /// Creates a textfield which users can type double values into. You can use
  /// the `num?.toInt()` function to turn this into an integer
  num number({
    required String label,
    String? description,
    num initialValue,
  });

  /// Creates a textfield which users can type double values into. You can use
  /// the `num?.toInt()` function to turn this into an integer
  /// Can optionally hold a null value
  num? nullableNumber({
    required String label,
    String? description,
    num? initialValue,
  });

  /// Allow the users to select from a list of options in a drop down box.
  /// The initial value is the first item in the list of options
  /// Must contain at least one value
  T options<T>({
    required String label,
    String? description,
    required List<Option<T>> options,
  });
}

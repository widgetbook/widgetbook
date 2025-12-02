import '../fields/fields.dart';
import '../framework/arg.dart';

class DateTimeArg extends Arg<DateTime> with SingleFieldOnly {
  DateTimeArg(
    super.value, {
    super.name,
    this.start,
    this.end,
  });

  final DateTime? start;
  final DateTime? end;

  @override
  Field<DateTime> get field {
    return DateTimeField(
      name: 'value',
      initialValue: value,
      start: start ?? value.subtract(const Duration(days: 365)),
      end: end ?? value.add(const Duration(days: 365)),
    );
  }
}

class NullableDateTimeArg extends Arg<DateTime?> with SingleFieldOnly {
  NullableDateTimeArg(
    super.value, {
    super.name,
    this.start,
    this.end,
  });

  final DateTime? start;
  final DateTime? end;

  @override
  Field<DateTime> get field {
    return DateTimeField(
      name: 'value',
      initialValue: value ?? DateTime.now(),
      start: start ?? DateTime.now().subtract(const Duration(days: 365)),
      end: end ?? DateTime.now().add(const Duration(days: 365)),
    );
  }
}

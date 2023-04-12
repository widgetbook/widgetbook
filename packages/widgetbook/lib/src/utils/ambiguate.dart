/// This allows a value of type T or T?
/// to be treated as a value of type T?.
///
/// We use this so that APIs that have become
/// non-nullable can still be used with `!` and `?`
/// to support older versions of the API as well.
///
/// It's mainly used to support [SchedulerBinding] and
/// [WidgetsBinding] on Flutter version 2 and 3.
///
/// For more info:
/// https://docs.flutter.dev/release/release-notes/release-notes-3.0.0#your-code
T? ambiguate<T>(T? value) => value;

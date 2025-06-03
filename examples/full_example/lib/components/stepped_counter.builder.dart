// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint

// **************************************************************************
// BuilderGenerator
// **************************************************************************

part of 'stepped_counter.dart';

Widget steppedCounterUseCaseGenerated(BuildContext context) {
  {
    return SteppedCounter(
      key: counterKey, // To preserve state
      step: context.knobs.int.slider(label: 'Step', initialValue: 1),
    );
  }
}

import 'package:args/args.dart';

extension ArgHelperExtension on ArgResults {
  bool get hasActor {
    return (this['actor'] as String?) != null;
  }

  String get actor {
    return this['actor'] as String;
  }

  bool get hasRepository {
    return (this['repository'] as String?) != null;
  }

  String get repository {
    return this['repository'] as String;
  }
}

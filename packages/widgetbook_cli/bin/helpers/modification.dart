import 'package:widgetbook_git/widgetbook_git.dart';

// TODO likely put this into git package
enum Modification {
  removed,
  changed,
  added,
}

extension FileDiffExtension on FileDiff {
  Modification get modification {
    if (isRemoved) {
      return Modification.removed;
    }

    if (isNew) {
      return Modification.added;
    }

    return Modification.changed;
  }
}

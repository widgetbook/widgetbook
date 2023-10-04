import 'modification.dart';

class DiffHeader {
  DiffHeader({
    this.base,
    this.ref,
  });

  /// Parses the [diff] header from `git diff` output.
  /// The [diff] header can look like this:
  ///
  /// ```diff
  /// diff --git a/builtin-http-fetch.c b/http-fetch.c
  /// similarity index 95%
  /// rename from builtin-http-fetch.c
  /// rename to http-fetch.c
  /// index f3e63d7..e8f44ba 100644
  /// --- a/builtin-http-fetch.c
  /// +++ b/http-fetch.c
  /// ```
  factory DiffHeader.parse(String diff) {
    return DiffHeader(
      base: RegExp(r'(?<=--- a).*').stringMatch(diff),
      ref: RegExp(r'(?<=\+\+\+ b).*').stringMatch(diff),
    );
  }

  final String? base;
  final String? ref;

  bool get isNew => base == null && ref != null;
  bool get isRemoved => base != null && ref == null;
  bool get isRenamed => base != ref && base != null && ref != null;

  Modification get modification {
    if (isRemoved) return Modification.removed;
    if (isNew) return Modification.added;
    return Modification.changed;
  }

  @override
  bool operator ==(covariant DiffHeader other) {
    if (identical(this, other)) return true;

    return other.base == base && other.ref == ref;
  }

  @override
  int get hashCode => base.hashCode ^ ref.hashCode;

  @override
  String toString() {
    return 'DiffHeader(base: $base, ref: $ref)';
  }
}

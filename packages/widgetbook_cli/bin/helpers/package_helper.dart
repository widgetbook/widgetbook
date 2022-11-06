import 'package:file/file.dart';
import 'package:pubspec/pubspec.dart';

enum PackageType {
  dartPackage,
  flutterPackage,
}

class PackageHelper {
  Future<bool> isFlutterPackage(Directory projectDirectory) async {
    final pubSpec = await PubSpec.load(projectDirectory);
    return _isFlutterPackage(pubSpec);
  }

  bool _isFlutterPackage(PubSpec pubSpec) {
    final dependencies = pubSpec.dependencies.keys.toList();

    late final isFlutterPackage = dependencies.contains('flutter');
    return isFlutterPackage;
  }
}

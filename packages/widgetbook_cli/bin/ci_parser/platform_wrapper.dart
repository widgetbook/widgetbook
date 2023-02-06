import 'dart:io';

class PlatformWrapper {
  String? environmentVariable({required String variable}) {
    return Platform.environment[variable];
  }
}

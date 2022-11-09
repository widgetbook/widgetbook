import 'dart:io';

class StdInWrapper {
  bool get hasTerminal => stdin.hasTerminal;
}

import '../viewport_data.dart';
import 'android_viewports.dart';
import 'ios_viewports.dart';
import 'linux_viewports.dart';
import 'macos_viewports.dart';
import 'windows_viewports.dart';

abstract class Viewports {
  static const Null none = null;

  static const all = <ViewportData?>[
    none,
    ...IosViewports.all,
    ...AndroidViewports.all,
    ...MacosViewports.all,
    ...WindowsViewports.all,
    ...LinuxViewports.all,
  ];
}

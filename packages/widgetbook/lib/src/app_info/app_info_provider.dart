import 'package:widgetbook/src/state_change_notifier.dart';
import 'package:widgetbook/widgetbook.dart';

class AppInfoProvider extends StateChangeNotifier<AppInfo> {
  AppInfoProvider({required AppInfo state}) : super(state: state);

  // ignore: use_setters_to_change_properties
  void hotReload(AppInfo appInfo) {
    state = appInfo;
  }
}

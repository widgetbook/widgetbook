import 'package:widgetbook/src/app_info/app_info.dart';
import 'package:widgetbook/src/state_change_notifier.dart';

class AppInfoProvider extends StateChangeNotifier<AppInfo> {
  AppInfoProvider({required AppInfo state}) : super(state: state);

  // ignore: use_setters_to_change_properties
  void hotReload(AppInfo appInfo) {
    state = appInfo;
  }
}

import 'package:widgetbook/src/state_change_notifier.dart';
import 'package:widgetbook/src/theming/theming_state.dart';

class ThemingProvider<CustomTheme>
    extends StateChangeNotifier<ThemingState<CustomTheme>> {
  ThemingProvider({
    required ThemingState<CustomTheme> state,
  }) : super(
          state: state,
        );
}

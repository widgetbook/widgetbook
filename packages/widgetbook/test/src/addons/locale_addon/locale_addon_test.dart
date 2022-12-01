import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/localization_addon/localization_provider.dart';
import 'package:widgetbook/src/addons/localization_addon/localization_selection_provider.dart';
import 'package:widgetbook/src/workbench/renderer.dart';
import 'package:widgetbook/widgetbook.dart';

import '../utils/addons.dart';
import '../utils/custom_app_theme.dart';
import '../utils/theme_wrapper.dart';
import 'flutter_gen/gen_l10n/app_localizations.dart';
import 'locale_addon_utilities.dart';

void main() {
  late Renderer sut;
  final rendererKey = GlobalKey();
  const localizationKey = Key('Localizations');

  setUp(() {
    sut = Renderer(
      key: rendererKey,
      appBuilder: (context, child) {
        return Localizations(
          key: localizationKey,
          locale: context.localization.activeLocale,
          delegates: localizationsDelegates,
          child: child,
        );
      },
      useCaseBuilder: (context) {
        return Text(
          AppLocalizations.of(context)!.newTag,
          key: textKey,
        );
      },
    );
  });

  group('$LocalizationAddon', () {
    testWidgets(
      'can access locale via the context',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          addOnProviderWrapper<AppThemeData>(
            child: sut,
            addons: [
              localizationAddon,
            ],
          ),
        );
        await tester.pumpAndSettle();

        final BuildContext context = tester.element(
          find
              .byKey(
                textKey,
              )
              .first,
        );

        final localeFromContext =
            context.read<LocalizationProvider>().value.activeLocale;

        expect(localeFromContext, engLocaleGb);

        final textFinder = find.byKey(textKey);

        expect(textFinder, findsOneWidget);
        final text = textFinder.evaluate().single.widget as Text;

        expect(text.data, equals('new_gb'));
      },
    );
    testWidgets(
      'can render all locales side by side ',
      (WidgetTester tester) async {
        await renderAddonSideBySide<AppThemeData>(
          itemsCollection: textDataList,
          expectedValues: <String>[
            'new_us',
            'new_gb',
            'neu',
            'nouvelle',
          ],
          itemsKey: textKey,
          tester: tester,
          sut: sut,
          addons: [
            LocalizationAddon(
              data: LocalizationSetting(
                activeLocales: {
                  engLocaleUs,
                  engLocaleGb,
                  germanLocale,
                  frenchLocale,
                },
                localizationsDelegates: localizationsDelegates,
                locales: locales,
              ),
            ),
          ],
        );
      },
    );

    testWidgets(
      'can activate a locale',
      (WidgetTester tester) async {
        await renderAddonSideBySide<AppThemeData>(
          itemsCollection: textDataList,
          expectedValues: <String>[
            'new_us',
            'new_gb',
            'neu',
            'nouvelle',
          ],
          itemsKey: textKey,
          tester: tester,
          sut: sut,
          shouldUpdate: true,
          updateAddon: (context) async =>
              context.read<LocalizationSettingProvider>().tapped(
                    frenchLocale,
                  ),
          addons: [
            LocalizationAddon(
              data: LocalizationSetting(
                activeLocales: {
                  engLocaleUs,
                  engLocaleGb,
                  germanLocale,
                },
                localizationsDelegates: localizationsDelegates,
                locales: locales,
              ),
            ),
          ],
        );
      },
    );

    testWidgets(
      'can de-activate a locale',
      (WidgetTester tester) async {
        await renderAddonSideBySide<AppThemeData>(
          itemsCollection: textDataList,
          expectedValues: <String>[
            'new_us',
            'new_gb',
            'neu',
          ],
          itemsKey: textKey,
          tester: tester,
          sut: sut,
          shouldUpdate: true,
          updateAddon: (context) async =>
              context.read<LocalizationSettingProvider>().tapped(
                    frenchLocale,
                  ),
          addons: [
            LocalizationAddon(
              data: LocalizationSetting(
                activeLocales: {
                  engLocaleUs,
                  engLocaleGb,
                  germanLocale,
                  frenchLocale
                },
                localizationsDelegates: localizationsDelegates,
                locales: locales,
              ),
            ),
          ],
        );
      },
    );
  });
}

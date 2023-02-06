import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/localization_addon/localization_provider.dart';
import 'package:widgetbook/src/addons/localization_addon/localization_selection_provider.dart';
import 'package:widgetbook/src/workbench/renderer.dart';
import 'package:widgetbook/widgetbook.dart';

import '../utils/addon_test_helper.dart';
import '../utils/addons.dart';
import '../utils/extensions/widget_tester_extension.dart';
import '../utils/theme_wrapper.dart';
import 'flutter_gen/gen_l10n/app_localizations.dart';
import 'locale_addon_utilities.dart';

Widget localeAddonWrapper({
  required Widget child,
  required List<Locale> locales,
  Locale? activeLocale,
}) {
  return addOnProviderWrapper<dynamic>(
    child: child,
    addons: [
      LocalizationAddon(
        setting: LocalizationSetting(
          activeLocale: activeLocale ?? locales.first,
          localizationsDelegates: localizationsDelegates,
          locales: locales,
        ),
      )
    ],
  );
}

void main() {
  late Renderer renderer;
  final rendererKey = GlobalKey();
  const localizationKey = Key('Localizations');

  setUp(() {
    renderer = Renderer(
      key: rendererKey,
      appBuilder: (context, child) {
        return Localizations(
          key: localizationKey,
          locale: context.localization!.activeLocale,
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
        await testAddon(
          tester: tester,
          build: (child) => localeAddonWrapper(
            child: child,
            locales: locales,
            activeLocale: engLocaleGb,
          ),
          child: renderer,
          expect: () {
            final context = tester.findContextByKey(textKey);

            final localeFromContext = context.read<LocalizationProvider>();
            expect(localeFromContext.value.activeLocale, equals(engLocaleGb));

            expectText(textData: 'new_gb');
          },
        );
      },
    );

    testWidgets(
      'can activate a locale',
      (WidgetTester tester) async {
        await testAddon(
          tester: tester,
          build: (child) => localeAddonWrapper(
            child: child,
            locales: locales,
            activeLocale: engLocaleGb,
          ),
          child: renderer,
          act: (context) async =>
              context.read<LocalizationSettingProvider>().tapped(engLocaleUs),
          expect: () {
            final context = tester.findContextByKey(textKey);

            final localeFromContext = context.read<LocalizationProvider>();
            expect(localeFromContext.value.activeLocale, equals(engLocaleUs));

            expectText(textData: 'new_us');
          },
        );
      },
    );

    testWidgets(
      'activates locales in order',
      (WidgetTester tester) async {
        await testAddon(
          tester: tester,
          build: (child) => localeAddonWrapper(
            child: child,
            locales: locales,
            activeLocale: engLocaleGb,
          ),
          child: renderer,
          act: (context) async => context.read<LocalizationSettingProvider>()
            ..tapped(engLocaleUs)
            ..tapped(germanLocale),
          expect: () {
            final context = tester.findContextByKey(textKey);

            final localeFromContext = context.read<LocalizationProvider>();
            expect(localeFromContext.value.activeLocale, equals(germanLocale));

            expectText(textData: 'neu');
          },
        );
      },
    );

    // Test for https://github.com/widgetbook/widgetbook/issues/232
    testWidgets(
      'supports locales with same language code',
      (tester) async {
        await testAddon(
          tester: tester,
          build: (child) => localeAddonWrapper(
            child: child,
            locales: [
              engLocaleUs,
              engLocaleGb,
            ],
            activeLocale: engLocaleUs,
          ),
          child: renderer,
          act: (context) async =>
              context.read<LocalizationSettingProvider>()..tapped(engLocaleGb),
          expect: () {
            final context = tester.findContextByKey(textKey);
            final provider = context.read<LocalizationProvider>();
            expect(provider.value.activeLocale, equals(engLocaleGb));
          },
        );
      },
    );
  });
}

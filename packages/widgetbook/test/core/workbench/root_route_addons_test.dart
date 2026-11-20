import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:widgetbook/src/core/widgetbook_app.dart';
import 'package:widgetbook/src/core/workbench/workbench.dart';
import 'package:widgetbook/widgetbook.dart';

// Reproduces https://github.com/widgetbook/widgetbook/issues/1893.
// Routes pushed on the root navigator (e.g. `showDialog` with its defaults)
// land in the navigator built by `AppRouterDelegate`, above `Workbench`, so
// they miss everything the addons apply and cover the whole Widgetbook UI.

typedef _Open = void Function(BuildContext context, WidgetBuilder builder);

class _NoArgs extends StoryArgs<Widget> {
  const _NoArgs();

  @override
  List<Arg?> get list => const [];
}

class _OpenerStory extends Story<Widget, _NoArgs> {
  _OpenerStory(_Open open)
    : super(
        name: 'Opener',
        args: const _NoArgs(),
        builder: (context, args) => Builder(
          builder: (context) {
            storyContext = context;
            return Center(
              child: ElevatedButton(
                onPressed: () => open(
                  context,
                  (routeContext) => Builder(
                    builder: (context) {
                      _OpenerStory.routeContext = context;
                      return const Text('route');
                    },
                  ),
                ),
                child: const Text('open'),
              ),
            );
          },
        ),
      );

  static late BuildContext storyContext;
  static late BuildContext routeContext;
}

final _rootRouteOpeners = <String, _Open>{
  'showDialog': (context, builder) => showDialog<void>(
    context: context,
    builder: (context) => Dialog(child: builder(context)),
  ),
  'showModalBottomSheet(useRootNavigator: true)': (context, builder) =>
      showModalBottomSheet<void>(
        context: context,
        useRootNavigator: true,
        builder: builder,
      ),
  'Navigator.of(rootNavigator: true).push': (context, builder) =>
      Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute<void>(builder: builder),
      ),
};

const _viewport = ViewportData(
  name: 'Square',
  width: 400,
  height: 400,
  pixelRatio: 1,
  platform: TargetPlatform.android,
);

void main() {
  Future<void> openRoute(
    WidgetTester tester, {
    required _Open open,
    required List<Addon<dynamic>> addons,
  }) async {
    tester.view.physicalSize = const Size(1600, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    final story = _OpenerStory(open);
    await tester.pumpWidget(
      WidgetbookApp(
        config: Config(
          initialRoute: '/?path=widgets/Dialog/Opener',
          addons: addons,
          components: [
            Component<Widget, _NoArgs>(
              path: 'widgets',
              name: 'Dialog',
              stories: [story],
            ),
          ],
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    expect(find.text('route'), findsOneWidget);
  }

  group('A route pushed on the root navigator from a story', () {
    for (final MapEntry(key: name, value: open) in _rootRouteOpeners.entries) {
      group('via $name', () {
        testWidgets(
          'given a $TextScaleAddon, '
          'then the route inherits the text scale',
          (tester) async {
            await openRoute(tester, open: open, addons: [TextScaleAddon(2)]);

            final storyScale = MediaQuery.textScalerOf(
              _OpenerStory.storyContext,
            ).scale(10);
            final routeScale = MediaQuery.textScalerOf(
              _OpenerStory.routeContext,
            ).scale(10);

            expect(storyScale, 20);
            expect(routeScale, 20);
          },
        );

        testWidgets(
          'given a $LocaleAddon, '
          'then the route inherits the locale',
          (tester) async {
            const locale = Locale('en', 'GB');
            await openRoute(
              tester,
              open: open,
              addons: [
                LocaleAddon(
                  [locale],
                  [
                    DefaultMaterialLocalizations.delegate,
                    DefaultWidgetsLocalizations.delegate,
                  ],
                ),
              ],
            );

            expect(Localizations.localeOf(_OpenerStory.storyContext), locale);
            expect(Localizations.localeOf(_OpenerStory.routeContext), locale);
          },
        );

        testWidgets(
          'given a $ViewportAddon, '
          'then the route inherits the viewport size',
          (tester) async {
            await openRoute(
              tester,
              open: open,
              addons: [
                ViewportAddon([_viewport]),
              ],
            );

            expect(
              MediaQuery.sizeOf(_OpenerStory.storyContext),
              _viewport.maxSize,
            );
            expect(
              MediaQuery.sizeOf(_OpenerStory.routeContext),
              _viewport.maxSize,
            );
          },
        );

        testWidgets(
          'then the route is drawn inside the workbench, '
          'not over the Widgetbook panels',
          (tester) async {
            await openRoute(tester, open: open, addons: []);

            expect(
              find.ancestor(
                of: find.text('route'),
                matching: find.byType(Workbench),
              ),
              findsOneWidget,
            );
          },
        );
      });
    }
  });

  testWidgets(
    'given a $TextScaleAddon and no $ViewportAddon, '
    'when a story opens a dialog with `useRootNavigator: false`, '
    'then the dialog inherits the text scale',
    (tester) async {
      await openRoute(
        tester,
        open: (context, builder) => showDialog<void>(
          context: context,
          useRootNavigator: false,
          builder: (context) => Dialog(child: builder(context)),
        ),
        addons: [TextScaleAddon(2)],
      );

      expect(
        MediaQuery.textScalerOf(_OpenerStory.routeContext).scale(10),
        20,
      );
    },
  );
}

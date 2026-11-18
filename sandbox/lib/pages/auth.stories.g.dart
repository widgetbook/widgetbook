// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering, unused_element, strict_raw_type

part of 'auth.stories.dart';

// **************************************************************************
// StoryGenerator
// **************************************************************************

typedef _Component = Component<ExamplePage, StoryArgs<ExamplePage>>;
typedef _Scenario = ExamplePageScenario;
typedef _Defaults = ExamplePageDefaults;
typedef _Story = ExamplePageStory;
typedef _Args = ExamplePageArgs;
final ExamplePageComponent = Component<ExamplePage, StoryArgs<ExamplePage>>(
  name: component.name ?? 'ExamplePage',
  path: component.path ?? 'pages',
  docsBuilder: component.docsBuilder,
  docComment: null,
  stories: [
    $Welcome..$generatedName = 'Welcome',
    $SignIn..$generatedName = 'SignIn',
    $SignUp..$generatedName = 'SignUp',
  ],
);
typedef ExamplePageScenario = Scenario<ExamplePage, ExamplePageArgs>;
typedef ExamplePageDefaults = Defaults<ExamplePage, ExamplePageArgs>;

class ExamplePageStory extends Story<ExamplePage, ExamplePageArgs> {
  ExamplePageStory({
    super.name,
    super.designLink,
    super.setup,
    super.modes,
    ExamplePageArgs? args,
    StoryWidgetBuilder<ExamplePage, ExamplePageArgs>? builder,
    super.scenarios,
    super.excludeFromTests,
  }) : super(
         args: args ?? ExamplePageArgs(),
         builder:
             builder ??
             (context, args) => ExamplePage(key: args.key, title: args.title),
       );
}

class ExamplePageArgs extends StoryArgs<ExamplePage> {
  ExamplePageArgs({Arg<Key?>? key, Arg<String>? title})
    : this.keyArg = $initArg('key', key, null),
      this.titleArg = $initArg('title', title, StringArg(''))!;

  ExamplePageArgs.fixed({Key? key, String title = ''})
    : this.keyArg = $initArg('key', key == null ? null : Arg.fixed(key), null),
      this.titleArg = $initArg('title', Arg.fixed(title), null)!;

  final Arg<Key?>? keyArg;

  final Arg<String> titleArg;

  Key? get key => keyArg?.value;

  String get title => titleArg.value;

  @override
  List<Arg?> get list => [keyArg, titleArg];
}

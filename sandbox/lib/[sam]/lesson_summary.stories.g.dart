// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering, unused_element, strict_raw_type

part of 'lesson_summary.stories.dart';

// **************************************************************************
// StoryGenerator
// **************************************************************************

typedef _Component = Component<LessonSummary, StoryArgs<LessonSummary>>;
typedef _Scenario = LessonSummaryScenario;
typedef _Defaults = LessonSummaryDefaults;
typedef _Story = LessonSummaryStory;
typedef _Args = LessonSummaryArgs;
final LessonSummaryComponent =
    Component<LessonSummary, StoryArgs<LessonSummary>>(
      name: component.name ?? 'LessonSummary',
      path: component.path ?? '[sam]',
      docsBuilder: component.docsBuilder,
      docComment: null,
      stories: [
        $Default..$generatedName = 'Default',
        $Long..$generatedName = 'Long',
      ],
    );
typedef LessonSummaryScenario = Scenario<LessonSummary, LessonSummaryArgs>;
typedef LessonSummaryDefaults = Defaults<LessonSummary, LessonSummaryArgs>;

class LessonSummaryStory extends Story<LessonSummary, LessonSummaryArgs> {
  LessonSummaryStory({
    super.name,
    super.designLink,
    super.setup,
    super.modes,
    LessonSummaryArgs? args,
    StoryWidgetBuilder<LessonSummary, LessonSummaryArgs>? builder,
    super.scenarios,
    super.excludeFromTests,
  }) : super(
         args: args ?? LessonSummaryArgs(),
         builder:
             builder ??
             (context, args) => LessonSummary(
               key: args.key,
               title: args.title,
               phraseCount: args.phraseCount,
             ),
       );
}

class LessonSummaryArgs extends StoryArgs<LessonSummary> {
  LessonSummaryArgs({Arg<Key?>? key, Arg<String>? title, Arg<int>? phraseCount})
    : this.keyArg = $initArg('key', key, null),
      this.titleArg = $initArg(
        'title',
        title,
        StringArg('Make an appointment'),
      )!,
      this.phraseCountArg = $initArg('phraseCount', phraseCount, IntArg(20))!;

  LessonSummaryArgs.fixed({
    Key? key,
    String title = 'Make an appointment',
    int phraseCount = 20,
  }) : this.keyArg = $initArg('key', key == null ? null : Arg.fixed(key), null),
       this.titleArg = $initArg('title', Arg.fixed(title), null)!,
       this.phraseCountArg = $initArg(
         'phraseCount',
         Arg.fixed(phraseCount),
         null,
       )!;

  final Arg<Key?>? keyArg;

  final Arg<String> titleArg;

  final Arg<int> phraseCountArg;

  Key? get key => keyArg?.value;

  String get title => titleArg.value;

  int get phraseCount => phraseCountArg.value;

  @override
  List<Arg?> get list => [keyArg, titleArg, phraseCountArg];
}

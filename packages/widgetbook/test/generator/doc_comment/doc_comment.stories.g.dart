// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doc_comment.stories.dart';

// **************************************************************************
// StoryGenerator
// **************************************************************************

typedef _Component = Component<DocCommentWidget, DocCommentWidgetArgs>;
typedef _Scenario = DocCommentWidgetScenario;
typedef _Defaults = DocCommentWidgetDefaults;
typedef _Story = DocCommentWidgetStory;
typedef _Args = DocCommentWidgetArgs;
final DocCommentWidgetComponent =
    Component<DocCommentWidget, DocCommentWidgetArgs>(
      name: meta.name ?? 'DocCommentWidget',
      path: meta.path ?? '',
      docsBuilder: meta.docsBuilder,
      docComment:
          'A widget with documentation.\n\nThis has an empty line above.',
      stories: [$Default..$generatedName = 'Default'],
    );
typedef DocCommentWidgetScenario =
    Scenario<DocCommentWidget, DocCommentWidgetArgs>;
typedef DocCommentWidgetDefaults =
    Defaults<DocCommentWidget, DocCommentWidgetArgs>;

class DocCommentWidgetStory
    extends Story<DocCommentWidget, DocCommentWidgetArgs> {
  DocCommentWidgetStory({
    super.name,
    super.setup,
    super.modes,
    DocCommentWidgetArgs? args,
    StoryWidgetBuilder<DocCommentWidget, DocCommentWidgetArgs>? builder,
    super.scenarios,
  }) : super(
         args: args ?? DocCommentWidgetArgs(),
         builder:
             builder ??
             (context, args) =>
                 DocCommentWidget(key: args.key, label: args.label),
       );
}

class DocCommentWidgetArgs extends StoryArgs<DocCommentWidget> {
  DocCommentWidgetArgs({Arg<Key?>? key, Arg<String>? label})
    : this.keyArg = $initArg('key', key, null),
      this.labelArg = $initArg('label', label, StringArg(''))!;

  DocCommentWidgetArgs.fixed({Key? key, String label = ''})
    : this.keyArg = key == null ? null : Arg.fixed(key),
      this.labelArg = Arg.fixed(label);

  final Arg<Key?>? keyArg;

  final Arg<String> labelArg;

  Key? get key => keyArg?.value;

  String get label => labelArg.value;

  @override
  List<Arg?> get list => [keyArg, labelArg];
}

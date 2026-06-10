// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doc_comment_code.stories.dart';

// **************************************************************************
// StoryGenerator
// **************************************************************************

typedef _Component =
    Component<DocCommentCodeWidget, StoryArgs<DocCommentCodeWidget>>;
typedef _Scenario = DocCommentCodeWidgetScenario;
typedef _Defaults = DocCommentCodeWidgetDefaults;
typedef _Story = DocCommentCodeWidgetStory;
typedef _Args = DocCommentCodeWidgetArgs;
final DocCommentCodeWidgetComponent =
    Component<DocCommentCodeWidget, StoryArgs<DocCommentCodeWidget>>(
      name: 'DocCommentCodeWidget',
      path: '',
      docComment: r'''Displays a [label].

```dart
DocCommentCodeWidget(label: '$name ($age)')
```''',
      stories: [$Default..$generatedName = 'Default'],
    );
typedef DocCommentCodeWidgetScenario =
    Scenario<DocCommentCodeWidget, DocCommentCodeWidgetArgs>;
typedef DocCommentCodeWidgetDefaults =
    Defaults<DocCommentCodeWidget, DocCommentCodeWidgetArgs>;

class DocCommentCodeWidgetStory
    extends Story<DocCommentCodeWidget, DocCommentCodeWidgetArgs> {
  DocCommentCodeWidgetStory({
    super.name,
    super.setup,
    super.modes,
    DocCommentCodeWidgetArgs? args,
    StoryWidgetBuilder<DocCommentCodeWidget, DocCommentCodeWidgetArgs>? builder,
    super.scenarios,
  }) : super(
         args: args ?? DocCommentCodeWidgetArgs(),
         builder:
             builder ??
             (context, args) =>
                 DocCommentCodeWidget(key: args.key, label: args.label),
       );
}

class DocCommentCodeWidgetArgs extends StoryArgs<DocCommentCodeWidget> {
  DocCommentCodeWidgetArgs({Arg<Key?>? key, Arg<String>? label})
    : this.keyArg = $initArg('key', key, null),
      this.labelArg = $initArg('label', label, StringArg(''))!;

  DocCommentCodeWidgetArgs.fixed({Key? key, String label = ''})
    : this.keyArg = key == null ? null : Arg.fixed(key),
      this.labelArg = Arg.fixed(label);

  final Arg<Key?>? keyArg;

  final Arg<String> labelArg;

  Key? get key => keyArg?.value;

  String get label => labelArg.value;

  @override
  List<Arg?> get list => [keyArg, labelArg];
}

import 'dart:async';
import 'dart:convert';

import 'package:dart_mcp/server.dart';

import 'comment.dart';
import 'comment_store.dart';

/// An MCP server that gives coding agents access to the comments placed
/// on stories in the Widgetbook UI.
///
/// It also declares the `claude/channel` capability, so clients that
/// support channels are notified as soon as the user submits a review.
final class CommentsMcpServer extends MCPServer
    with ToolsSupport, PromptsSupport {
  CommentsMcpServer(
    super.channel, {
    required this.store,
    required String version,
  }) : super.fromStreamChannel(
         implementation: Implementation(name: 'widgetbook', version: version),
         instructions: _instructions,
       ) {
    _subscription = store.submissions.listen(_onSubmitted);

    registerTool(_listTool, _list);
    registerTool(_getTool, _get);
    registerTool(_replyTool, _reply);
    registerTool(_setStatusTool, _setStatus);
    registerTool(_waitTool, _wait);
    addPrompt(_addressPrompt, _address);
  }

  final CommentStore store;
  late final StreamSubscription<List<Comment>> _subscription;

  final List<String> _undelivered = [];
  Completer<void>? _waiter;

  static const channelMethod = 'notifications/claude/channel';

  @override
  FutureOr<InitializeResult> initialize(InitializeRequest request) async {
    final result = await super.initialize(request);
    result.capabilities.experimental = {'claude/channel': <String, Object?>{}};
    return result;
  }

  @override
  Future<void> shutdown() async {
    await _subscription.cancel();
    await super.shutdown();
  }

  void _onSubmitted(List<Comment> comments) {
    _undelivered.addAll(comments.map((comment) => comment.id));
    _waiter?.complete();
    _waiter = null;

    final stories = comments.map((comment) => comment.storyPath).toSet();
    sendNotification(
      channelMethod,
      Notification({
        'content':
            'The user submitted ${comments.length} Widgetbook comment(s) '
            'on ${stories.join(', ')}. Address them with the widgetbook '
            'tools: get_comment for each id, change the code, then '
            'reply_to_comment and set_comment_status to "done".\n'
            'Ids: ${comments.map((comment) => comment.id).join(', ')}',
        'meta': {
          'count': '${comments.length}',
          'stories': stories.join(','),
        },
      }),
    );
  }

  static final _listTool = Tool(
    name: 'list_comments',
    description:
        'Lists the comments users placed on Widgetbook stories. '
        'By default only comments that wait for the agent '
        '(status "open" or "inProgress") are returned.',
    inputSchema: ObjectSchema(
      properties: {
        'status': StringSchema(
          description:
              'Filter by status: open, inProgress, done, resolved or all.',
        ),
        'storyPath': StringSchema(
          description: 'Only return comments on this story path.',
        ),
      },
    ),
  );

  CallToolResult _list(CallToolRequest request) {
    final status = request.arguments?['status'] as String?;
    final statuses = switch (status) {
      null => {CommentStatus.open, CommentStatus.inProgress},
      'all' => CommentStatus.values.toSet()..remove(CommentStatus.draft),
      _ => {CommentStatus.parse(status)},
    };

    final comments = store.list(
      storyPath: request.arguments?['storyPath'] as String?,
      statuses: statuses,
    );

    return _json(comments.map(_summary).toList());
  }

  static final _getTool = Tool(
    name: 'get_comment',
    description:
        'Returns a comment thread with the source location of the widget '
        'it is pinned to, the URL that restores the story state, '
        'and a screenshot of the story with the pin.',
    inputSchema: ObjectSchema(
      properties: {'id': StringSchema()},
      required: ['id'],
    ),
  );

  Future<CallToolResult> _get(CallToolRequest request) async {
    return _guard(() async {
      final comment = store.get(request.arguments!['id'] as String);
      final content = <Content>[
        Content.text(text: _encode(_details(comment))),
      ];

      if (comment.screenshot != null) {
        final file = store.screenshotFile(comment);
        if (file.existsSync()) {
          content
            ..add(Content.text(text: 'Screenshot: ${file.path}'))
            ..add(
              Content.image(
                data: base64Encode(await file.readAsBytes()),
                mimeType: 'image/png',
              ),
            );
        }
      }

      return CallToolResult(content: content);
    });
  }

  static final _replyTool = Tool(
    name: 'reply_to_comment',
    description:
        'Replies to a comment thread, e.g. to summarize the change '
        'or to ask the user a question.',
    inputSchema: ObjectSchema(
      properties: {'id': StringSchema(), 'text': StringSchema()},
      required: ['id', 'text'],
    ),
  );

  Future<CallToolResult> _reply(CallToolRequest request) {
    return _guard(() {
      final comment = store.reply(
        request.arguments!['id'] as String,
        CommentAuthor.agent,
        request.arguments!['text'] as String,
      );
      return _json(_summary(comment));
    });
  }

  static final _setStatusTool = Tool(
    name: 'set_comment_status',
    description:
        'Marks a comment as "inProgress" when starting to work on it, '
        'or as "done" once it is addressed. Only the user can resolve '
        'or reopen comments.',
    inputSchema: ObjectSchema(
      properties: {
        'id': StringSchema(),
        'status': StringSchema(description: 'inProgress or done'),
      },
      required: ['id', 'status'],
    ),
  );

  Future<CallToolResult> _setStatus(CallToolRequest request) {
    return _guard(() {
      final comment = store.setStatus(
        request.arguments!['id'] as String,
        CommentAuthor.agent,
        CommentStatus.parse(request.arguments!['status'] as String),
      );
      return _json(_summary(comment));
    });
  }

  static final _waitTool = Tool(
    name: 'wait_for_comments',
    description:
        'Waits until the user submits a review in the Widgetbook UI and '
        'returns its open comments. Returns right away if a review was '
        'submitted since the last call, and an empty list on timeout.',
    inputSchema: ObjectSchema(
      properties: {
        'timeoutSeconds': IntegerSchema(
          description: 'Defaults to 300.',
          minimum: 1,
          maximum: 3600,
        ),
      },
    ),
  );

  Future<CallToolResult> _wait(CallToolRequest request) async {
    final timeout = Duration(
      seconds: request.arguments?['timeoutSeconds'] as int? ?? 300,
    );

    if (_undelivered.isEmpty) {
      final waiter = _waiter ??= Completer<void>();
      await waiter.future.timeout(timeout, onTimeout: () {});
    }

    final ids = [..._undelivered];
    _undelivered.clear();

    final comments = store
        .list(statuses: {CommentStatus.open})
        .where((comment) => ids.contains(comment.id))
        .toList();

    return _json(comments.map(_summary).toList());
  }

  static final _addressPrompt = Prompt(
    name: 'address_comments',
    description: 'Address the open comments from the Widgetbook UI.',
  );

  GetPromptResult _address(GetPromptRequest request) {
    return GetPromptResult(
      messages: [
        PromptMessage(
          role: Role.user,
          content: Content.text(
            text:
                'Address the open Widgetbook comments. Call list_comments, '
                'then for each comment: get_comment, set_comment_status '
                '"inProgress", change the code, reply_to_comment with a short '
                'summary of the change, and set_comment_status "done". '
                'Afterwards call wait_for_comments and repeat until it '
                'returns no comments.',
          ),
        ),
      ],
    );
  }

  Map<String, Object?> _summary(Comment comment) {
    return {
      'id': comment.id,
      'status': comment.status.name,
      'storyPath': comment.storyPath,
      'text': comment.messages.first.text,
      'widget': _describeLocation(comment.anchor['location']),
      'replies': comment.messages.length - 1,
    };
  }

  Map<String, Object?> _details(Comment comment) {
    return {
      ...comment.toJson()..remove('screenshot'),
      'widget': _describeLocation(comment.anchor['location']),
    };
  }

  String? _describeLocation(Object? location) {
    if (location is! Map) return null;
    return '${location['widget']} at '
        '${location['file']}:${location['line']}:${location['column']}';
  }

  Future<CallToolResult> _guard(FutureOr<CallToolResult> Function() run) async {
    try {
      return await run();
    } on CommentNotFoundException catch (error) {
      return _error('$error');
    } on CommentTransitionException catch (error) {
      return _error('$error');
    } on FormatException catch (error) {
      return _error(error.message);
    }
  }

  CallToolResult _json(Object? value) {
    return CallToolResult(content: [Content.text(text: _encode(value))]);
  }

  CallToolResult _error(String message) {
    return CallToolResult(
      content: [Content.text(text: message)],
      isError: true,
    );
  }

  String _encode(Object? value) {
    return const JsonEncoder.withIndent('  ').convert(value);
  }

  static const _instructions = '''
Users place comments on stories in the Widgetbook UI. Each comment is pinned to a widget and carries the source location (file:line:column) where that widget is created, the chain of enclosing widgets from the user's code, the Widgetbook URL that restores the story state, and a screenshot with the pin.

Comments arrive in reviews: the user places several drafts and submits them together. When this server is loaded as a channel, each submitted review arrives as a <channel> event. Otherwise call wait_for_comments to wait for the next review.

For each comment: set_comment_status "inProgress", change the code, reply_to_comment with a short summary, then set_comment_status "done". Only the user resolves or reopens comments; a reply from the user reopens a "done" comment. The running Widgetbook app picks up the change after a hot reload.''';
}

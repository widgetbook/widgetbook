import 'package:flutter/widgets.dart';

import '../../fields/fields.dart';
import '../../framework/framework.dart';
import '../../state/state.dart';
import 'comments_client.dart';
import 'comments_layer.dart';

/// An [Addon] to place comments on the widgets of a story, which a coding
/// agent reads and addresses through the `widgetbook mcp` server.
///
/// Add it as the last addon, so that pins follow the story through the
/// viewport and zoom of the other addons. Comments are pinned to the source
/// location of the clicked widget, which Flutter only tracks in debug builds.
class CommentsAddon extends Addon<bool> with SingleFieldOnly {
  CommentsAddon({
    this.port = 7357,
    bool enabled = true,
  }) : super(
         name: 'Comments',
         initialValue: enabled,
       );

  /// The port of the `widgetbook mcp` server, set with its `--port` option.
  final int port;

  late final _client = CommentsClient(port: port);

  @override
  Field<bool> get field {
    return BooleanField(
      name: 'enabled',
      initialValue: initialValue,
    );
  }

  @override
  Widget apply(BuildContext context, Widget child, bool setting) {
    final state = WidgetbookState.maybeOf(context);
    final path = state?.path;
    if (!setting || state == null || path == null) return child;

    return CommentsLayer(
      client: _client,
      storyPath: path,
      storyUrl: state.uri.toString(),
      child: child,
    );
  }
}

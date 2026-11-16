import 'dart:async';
import 'dart:io';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:dart_mcp/stdio.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as p;

import '../../metadata.dart';
import '../comments/comments.dart';
import '../core/core.dart';

/// Starts the MCP server for coding agents, together with the local
/// HTTP API that the Widgetbook UI uses to store comments.
///
/// Stdout carries the MCP protocol, so this command only logs to stderr.
class McpCommand extends CliVoidCommand {
  McpCommand({
    required super.context,
    super.logger,
  }) : super(
         name: 'mcp',
         description:
             'Start the Widgetbook MCP server, which gives coding agents '
             'access to the comments placed on stories in the Widgetbook UI.',
       ) {
    argParser
      ..addOption(
        'root',
        help:
            'The project directory. Comments are stored in '
            '<root>/.widgetbook/comments.',
        defaultsTo: '.',
      )
      ..addOption(
        'port',
        help: 'The local port that the Widgetbook UI connects to.',
        defaultsTo: '${CommentsHttpServer.defaultPort}',
      );
  }

  @override
  FutureOr<int> runWith(Context context, ArgResults args) async {
    final port = int.tryParse(args['port'] as String);
    if (port == null) {
      throw UsageException('--port must be a number.', usage);
    }

    final store = CommentStore(
      root: p.normalize(p.absolute(args['root'] as String)),
    );

    final httpServer = CommentsHttpServer(store);
    try {
      await httpServer.start(port: port);
      stderr.writeln(
        'Widgetbook comments are available to the UI on port $port.',
      );
    } on SocketException catch (error) {
      stderr.writeln(
        'Port $port is in use (${error.message}). The agent can still '
        'read the comments, but the Widgetbook UI cannot store new ones '
        'through this server.',
      );
    }

    final mcpServer = CommentsMcpServer(
      stdioChannel(input: stdin, output: stdout),
      store: store,
      version: packageVersion,
    );

    await mcpServer.done;
    await httpServer.close();
    await store.close();

    return ExitCode.success.code;
  }
}

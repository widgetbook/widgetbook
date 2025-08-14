import 'dart:io';

import 'package:mcp_dart/mcp_dart.dart';

import '../../../widgetbook.dart';
import 'streamable_server.dart';

class McpIntegration extends WidgetbookIntegration {
  McpIntegration({int port = 3013}) : _port = port;

  final int _port;

  @override
  void onChange(WidgetbookState state) {
    print('MCP Integration: State changed');
    super.onChange(state);
    state = state;
  }

  @override
  Future<void> onInit(WidgetbookState state) async {
    super.onInit(state);

    // Map to store transports by session ID
    final transports = <String, StreamableHTTPServerTransport>{};

    // Create HTTP server
    final server = await HttpServer.bind(InternetAddress.anyIPv4, this._port);
    print('Widgetbook MCP Server listening on port ${_port}');

    await for (final request in server) {
      // Apply CORS headers to all responses
      setCorsHeaders(request.response);

      if (request.method == 'OPTIONS') {
        // Handle CORS preflight request
        request.response.statusCode = HttpStatus.ok;
        await request.response.close();
        continue;
      }

      if (request.uri.path != '/mcp') {
        // Not an MCP endpoint
        request.response
          ..statusCode = HttpStatus.notFound
          ..write('Not Found')
          ..close();
        continue;
      }

      switch (request.method) {
        case 'OPTIONS':
          // Handle preflight requests
          request.response.statusCode = HttpStatus.ok;
          await request.response.close();
          break;
        case 'POST':
          await handlePostRequest(request, transports, state);
          break;
        case 'GET':
          await handleGetRequest(request, transports);
          break;
        case 'DELETE':
          await handleDeleteRequest(request, transports);
          break;
        default:
          request.response
            ..statusCode = HttpStatus.methodNotAllowed
            ..headers.set(
              HttpHeaders.allowHeader,
              'GET, POST, DELETE, OPTIONS',
            );
          // CORS headers already applied at the top
          request.response
            ..write('Method Not Allowed')
            ..close();
      }
    }
  }
}

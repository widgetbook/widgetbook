import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';

import '../framework/framework.dart';
import '../state/state.dart';
import 'atlas_layout.dart';

/// Opens [node] of [flow]: a page's story, a page's state below its flow, or a
/// terminal's url.
@internal
void openAtlasNode(BuildContext context, AtlasFlow flow, AtlasNode node) {
  final state = WidgetbookState.of(context);

  switch (node) {
    case AtlasPage(args: _?):
      state.updatePath(atlasPagePath(flow, node));
    case AtlasPage():
      state.goToStory(node.story);
    case AtlasTerminal(:final url?):
      launchUrl(Uri.parse(url));
  }
}

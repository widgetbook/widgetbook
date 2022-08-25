import 'package:flutter/material.dart';
import 'package:widgetbook/src/addons/addon.dart';

class AddonPanel extends StatefulWidget {
  const AddonPanel({
    Key? key,
    required this.plugins,
    required this.layerLink,
    required this.overlayKey,
  }) : super(key: key);

  final List<WidgetbookAddOn> plugins;
  final LayerLink layerLink;
  final GlobalKey<OverlayState> overlayKey;

  @override
  State<AddonPanel> createState() => _AddonPanelState();
}

class _AddonPanelState extends State<AddonPanel> {
  PluginOverlay? _overlay;

  OverlayEntry _createEntry(WidgetBuilder childBuilder) => OverlayEntry(
        builder: (context) => Positioned(
          height: 350,
          width: 600,
          child: CompositedTransformFollower(
            targetAnchor: Alignment.bottomCenter,
            followerAnchor: Alignment.topCenter,
            link: widget.layerLink,
            showWhenUnlinked: false,
            child: Localizations(
              delegates: const [
                DefaultMaterialLocalizations.delegate,
                DefaultWidgetsLocalizations.delegate,
              ],
              locale: const Locale('en', 'US'),
              child: Dialog(
                clipBehavior: Clip.antiAlias,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                insetPadding: EdgeInsets.zero,
                child: Navigator(
                  onGenerateRoute: (_) => MaterialPageRoute<void>(
                    builder: (context) => Material(
                      child: childBuilder(context),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  void _onPluginButtonPressed(WidgetbookAddOn p) {
    final panelBuilder = p.builder;

    void insertOverlay() {
      final overlay =
          PluginOverlay(plugin: p, entry: _createEntry(panelBuilder));
      _overlay = overlay;
      widget.overlayKey.currentState?.insert(overlay.entry);
    }

    final overlay = _overlay;
    if (overlay != null) {
      overlay.remove();
      if (overlay.plugin != p) {
        insertOverlay();
      } else {
        _overlay = null;
      }
    } else {
      insertOverlay();
    }
  }

  @override
  Widget build(BuildContext context) => Wrap(
        runAlignment: WrapAlignment.center,
        children: widget.plugins
            .where((p) => p.icon != null)
            .map(
              (p) => IconButton(
                // ignore: avoid-non-null-assertion, checked for null
                icon: p.icon,
                onPressed: () => _onPluginButtonPressed(p),
              ),
            )
            .toList(),
      );
}

@immutable
class PluginOverlay {
  const PluginOverlay({required this.entry, required this.plugin});

  final OverlayEntry entry;
  final WidgetbookAddOn plugin;

  void remove() => entry.remove();
}

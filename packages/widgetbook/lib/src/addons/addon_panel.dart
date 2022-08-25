import 'package:flutter/material.dart';
import 'package:widgetbook/src/addons/addon.dart';
import 'package:widgetbook/src/addons/models/panel_size.dart';

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

  OverlayEntry _createEntry(WidgetbookAddOn addon) => OverlayEntry(
        builder: (context) => Positioned(
          height: 350,
          width: addon.panelSize == PanelSize.small ? 300 : 600,
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    8,
                  ),
                ),
                backgroundColor: const Color(0xFF3d3d3d),
                insetPadding: EdgeInsets.zero,
                child: Navigator(
                  onGenerateRoute: (_) => MaterialPageRoute<void>(
                    builder: (context) => Material(
                      child: addon.builder(context),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  void _onPluginButtonPressed(WidgetbookAddOn p) {
    void insertOverlay() {
      final overlay = PluginOverlay(plugin: p, entry: _createEntry(p));
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

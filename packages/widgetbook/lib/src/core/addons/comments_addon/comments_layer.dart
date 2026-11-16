import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;

import 'anchor_locator.dart';
import 'comment.dart';
import 'comment_tap_recognizer.dart';
import 'comments_client.dart';

/// Shows the comments of a story as pins and lets the user place new ones.
///
/// Pins are attached to widgets rather than to screen positions, so they
/// follow the widgets when the story scrolls, zooms or is hot reloaded.
@internal
class CommentsLayer extends StatefulWidget {
  const CommentsLayer({
    super.key,
    required this.client,
    required this.storyPath,
    required this.storyUrl,
    required this.child,
    this.pollInterval = const Duration(seconds: 2),
  });

  final CommentsClient client;
  final String storyPath;
  final String storyUrl;
  final Widget child;
  final Duration pollInterval;

  @override
  State<CommentsLayer> createState() => _CommentsLayerState();
}

class _CommentsLayerState extends State<CommentsLayer> {
  final _storyKey = GlobalKey();
  final _portal = OverlayPortalController();

  AnchorLocator? _locator;
  Object? _error;
  String? _actionError;
  Timer? _poll;

  List<StoryComment> _comments = const [];
  String _signature = '';
  final _resolved = <String, ResolvedAnchor?>{};

  /// The scrollables of comments whose list item is not built.
  final _scrollables = <String, ScrollableState>{};
  bool _needsResolve = true;
  bool _scrolled = false;
  Map<String, _Pin> _pins = const {};

  bool _commenting = false;
  bool _pinsHidden = false;
  _Highlight? _highlight;
  _Composer? _composer;
  String? _openId;

  Element? get _story => _storyKey.currentContext as Element?;

  /// Pins and cards are shown in the closest [Overlay], i.e. the viewport's
  /// device frame or the workbench, so they fit even around small widgets.
  RenderBox? get _overlayBox {
    final box = Overlay.maybeOf(context)?.context.findRenderObject();
    return box is RenderBox && box.hasSize ? box : null;
  }

  @override
  void initState() {
    super.initState();
    _connect();
    _poll = Timer.periodic(widget.pollInterval, (_) => _refresh());
    _schedulePinUpdate();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _portal.show();
    });
  }

  @override
  void didUpdateWidget(CommentsLayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.storyPath != widget.storyPath) {
      _comments = const [];
      _signature = '';
      _composer = null;
      _openId = null;
      _refresh();
    }
  }

  @override
  void reassemble() {
    super.reassemble();
    _needsResolve = true;
  }

  @override
  void dispose() {
    _poll?.cancel();
    super.dispose();
  }

  Future<void> _connect() async {
    final widgetbookPrefix = AnchorLocator.packagePrefix(
      AnchorLocator.creationUri(context as Element),
    );

    try {
      final root = await widget.client.root();
      _locator = AnchorLocator(root: root, excludedPrefix: widgetbookPrefix);
      await _refresh();
    } catch (error) {
      if (!mounted) return;
      setState(() => _error = error);
    }
  }

  /// Loads the comments of the story. Calls during a load are coalesced into
  /// one follow-up load, so that polls never overlap.
  Future<void> _refresh() async {
    if (_refreshing) {
      _refreshQueued = true;
      return;
    }

    _refreshing = true;
    try {
      do {
        _refreshQueued = false;
        await _load();
      } while (_refreshQueued && mounted);
    } finally {
      _refreshing = false;
    }
  }

  bool _refreshing = false;
  bool _refreshQueued = false;

  Future<void> _load() async {
    if (_locator == null) {
      if (_error != null) return _connect();
      return;
    }

    final storyPath = widget.storyPath;
    try {
      final comments = await widget.client.list(storyPath);
      if (!mounted || storyPath != widget.storyPath) return;

      final signature = comments
          .map((c) => '${c.id}:${c.status.name}:${c.messages.length}')
          .join(',');

      if (signature != _signature || _error != null) {
        setState(() {
          _comments = comments;
          _signature = signature;
          _error = null;
          _needsResolve = true;
        });
      }
    } catch (error) {
      if (!mounted) return;
      setState(() => _error = error);
    }
  }

  List<StoryComment> get _visibleComments {
    return _comments
        .where((comment) => comment.status != CommentStatus.resolved)
        .toList();
  }

  int get _draftCount {
    return _comments
        .where((comment) => comment.status == CommentStatus.draft)
        .length;
  }

  /// Pins are positioned after each frame, so that they follow their widgets
  /// through scrolling, animations and layout changes. This does not
  /// schedule frames by itself, so it is idle while nothing changes.
  void _schedulePinUpdate() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _updatePins();
      _schedulePinUpdate();
    });
  }

  void _updatePins() {
    final story = _story;
    final locator = _locator;
    final layerBox = _overlayBox;
    if (story == null || locator == null || layerBox == null) return;

    final unmounted =
        _resolved.values.any(
          (resolved) => resolved != null && !resolved.element.mounted,
        ) ||
        _scrollables.values.any((scrollable) => !scrollable.mounted);
    final retryUnresolved = _scrolled && _resolved.containsValue(null);
    _scrolled = false;

    if (_needsResolve || unmounted || retryUnresolved) {
      final resolveAll = _needsResolve || unmounted;
      _needsResolve = false;

      locator.batch(story, () {
        for (final comment in _comments) {
          if (resolveAll || _resolved[comment.id] == null) {
            _resolved[comment.id] = locator.resolve(story, comment.anchor);
          }
        }

        _scrollables.clear();
        for (final comment in _comments) {
          if (_resolved[comment.id] != null) continue;
          final scrollable = locator.scrollableOf(story, comment.anchor);
          if (scrollable != null) _scrollables[comment.id] = scrollable;
        }
      });
    }

    final storyBox = story.findRenderObject();
    if (storyBox is! RenderBox || !storyBox.hasSize) return;
    final storyRect = _rectIn(layerBox, storyBox);

    final pins = {
      for (final comment in _visibleComments)
        comment.id: _pinFor(comment, layerBox, storyRect),
    };

    if (!mapEquals(pins, _pins)) {
      setState(() => _pins = pins);
    }
  }

  _Pin _pinFor(StoryComment comment, RenderBox layerBox, Rect storyRect) {
    final resolved = _resolved[comment.id];
    final box = resolved?.element.findRenderObject();

    if (resolved != null &&
        resolved.element.mounted &&
        box is RenderBox &&
        box.attached &&
        box.hasSize) {
      final offset = resolved.exact
          ? comment.anchor.offset ?? const FractionalPoint(0.5, 0.5)
          : const FractionalPoint(0.5, 0.5);
      final point = MatrixUtils.transformPoint(
        box.getTransformTo(layerBox),
        Offset(offset.x * box.size.width, offset.y * box.size.height),
      );

      final scrollable = resolved.element
          .findAncestorStateOfType<ScrollableState>();
      final viewportBox = scrollable?.context.findRenderObject();
      final visibleRect = viewportBox is RenderBox && viewportBox.hasSize
          ? _rectIn(layerBox, viewportBox).intersect(storyRect)
          : storyRect;

      return _Pin(
        position: _clamp(point, visibleRect),
        offscreen: !visibleRect.contains(point),
        detached: false,
      );
    }

    final point =
        storyRect.topLeft +
        Offset(
          comment.anchor.point.x * storyRect.width,
          comment.anchor.point.y * storyRect.height,
        );

    return _scrolledAwayPin(comment, point, layerBox, storyRect) ??
        _Pin(
          position: _clamp(point, storyRect),
          offscreen: false,
          detached: true,
        );
  }

  /// Places the pin of a list item that is not built, because its list is
  /// scrolled elsewhere, where the item would be: at the edge of the list
  /// in the item's direction.
  _Pin? _scrolledAwayPin(
    StoryComment comment,
    Offset point,
    RenderBox layerBox,
    Rect storyRect,
  ) {
    final contentOffset = comment.anchor.scroll?.contentOffset;
    if (contentOffset == null) return null;

    final scrollable = _scrollables[comment.id];
    final viewportBox = scrollable?.context.findRenderObject();
    if (scrollable == null ||
        viewportBox is! RenderBox ||
        !viewportBox.hasSize ||
        !scrollable.position.hasPixels) {
      return null;
    }

    final along = contentOffset - scrollable.position.pixels;
    final local = viewportBox.globalToLocal(layerBox.localToGlobal(point));
    final expected = MatrixUtils.transformPoint(
      viewportBox.getTransformTo(layerBox),
      scrollable.position.axis == Axis.vertical
          ? Offset(local.dx, along)
          : Offset(along, local.dy),
    );
    final visibleRect = _rectIn(layerBox, viewportBox).intersect(storyRect);
    final offscreen = !visibleRect.contains(expected);

    return _Pin(
      position: _clamp(expected, visibleRect),
      offscreen: offscreen,
      detached: !offscreen,
    );
  }

  static Rect _rectIn(RenderBox ancestor, RenderBox box) {
    return MatrixUtils.transformRect(
      box.getTransformTo(ancestor),
      Offset.zero & box.size,
    );
  }

  static Offset _clamp(Offset point, Rect rect) {
    return Offset(
      point.dx.clamp(rect.left, rect.right),
      point.dy.clamp(rect.top, rect.bottom),
    );
  }

  void _onHover(PointerHoverEvent event) {
    final story = _story;
    final locator = _locator;
    final layerBox = _overlayBox;
    if (story == null || locator == null || layerBox == null) return;

    final element = locator.elementAt(story, event.position);
    final location = element == null ? null : locator.locationOf(element);
    final box = element?.findRenderObject();

    final highlight = location == null || box is! RenderBox
        ? null
        : _Highlight(
            rect: _rectIn(layerBox, box),
            label:
                '${location.widget} · '
                '${p.basename(location.file)}:${location.line}',
          );

    if (highlight != _highlight) {
      setState(() => _highlight = highlight);
    }
  }

  void _onTap(Offset globalPosition) {
    final story = _story;
    final locator = _locator;
    final layerBox = _overlayBox;
    if (story == null || locator == null || layerBox == null) return;

    if (_composer != null || _openId != null) {
      setState(() {
        _composer = null;
        _openId = null;
      });
      return;
    }

    setState(() {
      _highlight = null;
      _composer = _Composer(
        anchor: locator.capture(story, globalPosition),
        position: layerBox.globalToLocal(globalPosition),
      );
    });
  }

  Future<bool> _createComment(String text) async {
    final composer = _composer;
    if (composer == null || text.trim().isEmpty) return false;

    final screenshot = await _screenshot(composer.anchor.point);
    final saved = await _run(
      'Could not save the comment',
      () => widget.client.create(
        storyPath: widget.storyPath,
        storyUrl: widget.storyUrl,
        text: text.trim(),
        anchor: composer.anchor,
        screenshot: screenshot,
      ),
    );

    if (saved && mounted) setState(() => _composer = null);
    return saved;
  }

  /// Captures the story without the comment overlay, with a ring around
  /// the pin, so that the agent can see what the comment refers to.
  Future<Uint8List?> _screenshot(FractionalPoint pin) async {
    final boundary = _story?.findRenderObject();
    if (boundary is! RenderRepaintBoundary) return null;

    ui.Image? image;
    ui.Image? composed;
    try {
      image = await boundary.toImage(pixelRatio: 2);
      final recorder = ui.PictureRecorder();
      final center = Offset(pin.x * image.width, pin.y * image.height);

      Canvas(recorder)
        ..drawImage(image, Offset.zero, Paint())
        ..drawCircle(
          center,
          24,
          Paint()
            ..color = const Color(0xFFE53935)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 5,
        );

      final picture = recorder.endRecording();
      composed = await picture.toImage(image.width, image.height);
      picture.dispose();

      final bytes = await composed.toByteData(format: ui.ImageByteFormat.png);
      return bytes?.buffer.asUint8List();
    } catch (_) {
      return null;
    } finally {
      image?.dispose();
      composed?.dispose();
    }
  }

  /// Runs an action against the server and reports whether it succeeded.
  /// A failure is shown in the toolbar, prefixed with [failure].
  Future<bool> _run(String failure, Future<void> Function() action) async {
    try {
      await action();
      if (mounted) setState(() => _actionError = null);
      await _refresh();
      return true;
    } catch (error) {
      if (mounted) {
        setState(() => _actionError = '$failure: ${_describe(error)}');
      }
      return false;
    }
  }

  /// The server's error message in [error], or the error itself, e.g. when
  /// the server is not reachable.
  static String _describe(Object error) {
    final serverMessage = RegExp(
      r'"error"\s*:\s*"((?:[^"\\]|\\.)*)"',
    ).firstMatch('$error')?.group(1);
    if (serverMessage != null) return serverMessage.replaceAll(r'\"', '"');

    return '$error'.split('\n').first;
  }

  void _openPin(StoryComment comment) {
    final pin = _pins[comment.id];
    final resolved = _resolved[comment.id];
    final story = _story;

    if (pin != null && pin.offscreen && resolved != null) {
      Scrollable.ensureVisible(
        resolved.element,
        alignment: 0.5,
        duration: const Duration(milliseconds: 250),
      );
    } else if (pin != null &&
        (pin.offscreen || pin.detached) &&
        story != null) {
      if (_locator?.restoreScroll(story, comment.anchor) ?? false) {
        _needsResolve = true;
      }
    }

    setState(() {
      _composer = null;
      _openId = _openId == comment.id ? null : comment.id;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget story = NotificationListener<ScrollNotification>(
      onNotification: (_) {
        _scrolled = true;
        return false;
      },
      child: RepaintBoundary(
        key: _storyKey,
        child: widget.child,
      ),
    );

    if (_commenting) {
      story = MouseRegion(
        cursor: SystemMouseCursors.precise,
        onHover: _onHover,
        onExit: (_) => setState(() => _highlight = null),
        child: RawGestureDetector(
          gestures: {
            CommentTapRecognizer:
                GestureRecognizerFactoryWithHandlers<CommentTapRecognizer>(
                  () => CommentTapRecognizer(debugOwner: this),
                  (recognizer) => recognizer.onTap = _onTap,
                ),
          },
          child: story,
        ),
      );
    }

    final overlay = Positioned.fill(
      child: _Chrome(
        child: LayoutBuilder(
          builder: (context, constraints) => Stack(
            clipBehavior: Clip.none,
            children: _buildOverlay(constraints.biggest),
          ),
        ),
      ),
    );

    return OverlayPortal(
      controller: _portal,
      overlayChildBuilder: (_) => overlay,
      child: story,
    );
  }

  List<Widget> _buildOverlay(Size size) {
    final visible = _visibleComments;
    final open = visible.where((comment) => comment.id == _openId).firstOrNull;
    final composer = _composer;

    return [
      if (_commenting && _highlight != null)
        Positioned.fromRect(
          rect: _highlight!.rect,
          child: IgnorePointer(child: _HighlightBox(_highlight!.label)),
        ),
      if (!_pinsHidden)
        for (final (index, comment) in visible.indexed)
          if (_pins[comment.id] case final pin?)
            Positioned(
              left: pin.position.dx - _PinBadge.radius,
              top: pin.position.dy - _PinBadge.radius,
              child: _PinBadge(
                number: index + 1,
                status: comment.status,
                faded: pin.offscreen || pin.detached,
                selected: comment.id == _openId,
                onTap: () => _openPin(comment),
              ),
            ),
      if (composer != null)
        _card(
          size: size,
          anchor: composer.position,
          child: _CommentComposer(
            onSubmit: _createComment,
            onCancel: () => setState(() => _composer = null),
          ),
        ),
      if (open != null && _pins[open.id] != null)
        _card(
          size: size,
          anchor: _pins[open.id]!.position,
          child: _ThreadCard(
            comment: open,
            detached: _pins[open.id]!.detached,
            onClose: () => setState(() => _openId = null),
            onReply: (text) => _run(
              'Could not send the reply',
              () => widget.client.reply(open.id, text),
            ),
            onStatus: (status) => _run(
              'Could not update the comment',
              () => widget.client.setStatus(open.id, status),
            ),
            onDelete: () async {
              final deleted = await _run(
                'Could not delete the comment',
                () => widget.client.delete(open.id),
              );
              if (deleted && mounted) setState(() => _openId = null);
            },
          ),
        ),
      Positioned(
        left: 0,
        right: 0,
        bottom: 12,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            if (_statusMessage case final message?)
              Center(
                child: _Toolbar(
                  color: _errorSurface,
                  children: [
                    _ToolbarLabel(message),
                    if (_actionError != null)
                      _ToolbarButton(
                        icon: Icons.close,
                        onPressed: () => setState(() => _actionError = null),
                      ),
                  ],
                ),
              ),
            Center(child: _buildToolbar()),
          ],
        ),
      ),
    ];
  }

  /// An error to show while connected: a failed action, or the lost
  /// connection to the server, which clears on the next successful poll.
  String? get _statusMessage {
    if (_actionError != null) return _actionError;
    if (_error != null && _locator != null) {
      return 'Lost the connection to `widgetbook mcp`';
    }
    return null;
  }

  Widget _card({
    required Size size,
    required Offset anchor,
    required Widget child,
  }) {
    final width = math.min(280.0, size.width - 16);
    final left = math.max(
      8.0,
      math.min(anchor.dx + 18, size.width - width - 8),
    );
    final top = math.max(8.0, math.min(anchor.dy - 12, size.height - 180));

    return Positioned(
      left: left,
      top: top,
      width: math.max(width, 0),
      child: child,
    );
  }

  Widget _buildToolbar() {
    if (_error != null && _locator == null) {
      return _Toolbar(
        children: [
          const _ToolbarLabel('Run `widgetbook mcp` to enable comments'),
          _ToolbarButton(icon: Icons.refresh, onPressed: _connect),
        ],
      );
    }

    if (!_commenting) {
      final active = _visibleComments.length;
      return _Toolbar(
        children: [
          _ToolbarButton(
            icon: Icons.add_comment_outlined,
            label: active == 0 ? 'Comment' : '$active',
            onPressed: () => setState(() => _commenting = true),
          ),
        ],
      );
    }

    final drafts = _draftCount;
    return _Toolbar(
      children: [
        _ToolbarLabel(
          drafts == 0 ? 'Click a widget to comment' : 'Commenting · $drafts',
        ),
        _ToolbarButton(
          icon: _pinsHidden
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          onPressed: () => setState(() => _pinsHidden = !_pinsHidden),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            visualDensity: VisualDensity.compact,
          ),
          onPressed: drafts == 0
              ? null
              : () => _run(
                  'Could not submit the review',
                  () => widget.client.submit(widget.storyPath),
                ),
          child: const Text('Submit'),
        ),
        _ToolbarButton(
          icon: Icons.close,
          onPressed: () => setState(() {
            _commenting = false;
            _composer = null;
            _highlight = null;
          }),
        ),
      ],
    );
  }
}

@immutable
class _Pin {
  const _Pin({
    required this.position,
    required this.offscreen,
    required this.detached,
  });

  final Offset position;
  final bool offscreen;
  final bool detached;

  @override
  bool operator ==(Object other) =>
      other is _Pin &&
      other.position == position &&
      other.offscreen == offscreen &&
      other.detached == detached;

  @override
  int get hashCode => Object.hash(position, offscreen, detached);
}

@immutable
class _Highlight {
  const _Highlight({required this.rect, required this.label});

  final Rect rect;
  final String label;

  @override
  bool operator ==(Object other) =>
      other is _Highlight && other.rect == rect && other.label == label;

  @override
  int get hashCode => Object.hash(rect, label);
}

class _Composer {
  const _Composer({required this.anchor, required this.position});

  final CommentAnchor anchor;
  final Offset position;
}

const _accent = Color(0xFF2F6BFF);
const _surface = Color(0xFF1E1E1E);
const _errorSurface = Color(0xFFB3261E);

class _Chrome extends StatelessWidget {
  const _Chrome({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Localizations(
      locale: const Locale('en'),
      delegates: const [
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      child: Theme(
        data: ThemeData(
          brightness: Brightness.dark,
          colorSchemeSeed: _accent,
        ),
        child: DefaultTextStyle(
          style: const TextStyle(color: Colors.white, fontSize: 13),
          child: child,
        ),
      ),
    );
  }
}

class _HighlightBox extends StatelessWidget {
  const _HighlightBox(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: _accent, width: 2),
            ),
          ),
        ),
        Positioned(
          left: 0,
          bottom: -22,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            color: _accent,
            child: Text(
              label,
              style: const TextStyle(fontSize: 11),
              maxLines: 1,
            ),
          ),
        ),
      ],
    );
  }
}

class _PinBadge extends StatelessWidget {
  const _PinBadge({
    required this.number,
    required this.status,
    required this.faded,
    required this.selected,
    required this.onTap,
  });

  static const radius = 13.0;

  final int number;
  final CommentStatus status;
  final bool faded;
  final bool selected;
  final VoidCallback onTap;

  Color get _color => switch (status) {
    CommentStatus.draft => const Color(0xFF757575),
    CommentStatus.open => _accent,
    CommentStatus.inProgress => const Color(0xFFF59E0B),
    CommentStatus.done => const Color(0xFF16A34A),
    CommentStatus.resolved => const Color(0xFF757575),
  };

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Opacity(
          opacity: faded ? 0.5 : 1,
          child: Container(
            width: radius * 2,
            height: radius * 2,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _color,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: selected ? 3 : 2,
              ),
              boxShadow: const [
                BoxShadow(blurRadius: 4, color: Colors.black26),
              ],
            ),
            child: Text(
              '$number',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _surface,
      elevation: 8,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: child,
      ),
    );
  }
}

class _MessageField extends StatefulWidget {
  const _MessageField({
    required this.hint,
    required this.onSubmit,
    this.onCancel,
    this.autofocus = false,
  });

  final String hint;

  /// Sends the text and reports whether it was saved. The text stays in
  /// the field when it was not, so that it is not lost.
  final Future<bool> Function(String text) onSubmit;
  final VoidCallback? onCancel;
  final bool autofocus;

  @override
  State<_MessageField> createState() => _MessageFieldState();
}

class _MessageFieldState extends State<_MessageField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final text = _controller.text;
    if (text.trim().isEmpty) return;

    final saved = await widget.onSubmit(text);
    if (saved && mounted && _controller.text == text) _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: {
        if (widget.onCancel != null)
          const SingleActivator(LogicalKeyboardKey.escape): widget.onCancel!,
      },
      child: TextField(
        controller: _controller,
        autofocus: widget.autofocus,
        minLines: 1,
        maxLines: 4,
        textInputAction: TextInputAction.send,
        onSubmitted: (_) => _submit(),
        style: const TextStyle(color: Colors.white, fontSize: 13),
        decoration: InputDecoration(
          isDense: true,
          hintText: widget.hint,
          border: InputBorder.none,
          suffixIcon: IconButton(
            icon: const Icon(Icons.arrow_upward, size: 18),
            onPressed: _submit,
          ),
        ),
      ),
    );
  }
}

class _CommentComposer extends StatelessWidget {
  const _CommentComposer({required this.onSubmit, required this.onCancel});

  final Future<bool> Function(String text) onSubmit;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: _MessageField(
        hint: 'Add a comment',
        autofocus: true,
        onSubmit: onSubmit,
        onCancel: onCancel,
      ),
    );
  }
}

class _ThreadCard extends StatelessWidget {
  const _ThreadCard({
    required this.comment,
    required this.detached,
    required this.onClose,
    required this.onReply,
    required this.onStatus,
    required this.onDelete,
  });

  final StoryComment comment;
  final bool detached;
  final VoidCallback onClose;
  final Future<bool> Function(String text) onReply;
  final ValueChanged<CommentStatus> onStatus;
  final VoidCallback onDelete;

  String get _statusLabel => switch (comment.status) {
    CommentStatus.draft => 'Draft · not submitted',
    CommentStatus.open => 'Waiting for the agent',
    CommentStatus.inProgress => 'Agent is working on it',
    CommentStatus.done => 'Done · verify and resolve',
    CommentStatus.resolved => 'Resolved',
  };

  @override
  Widget build(BuildContext context) {
    final location = comment.anchor.location;
    final status = comment.status;

    return _Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  _statusLabel,
                  style: const TextStyle(fontSize: 11, color: Colors.white70),
                ),
              ),
              InkWell(onTap: onClose, child: const Icon(Icons.close, size: 16)),
            ],
          ),
          if (location != null)
            Text(
              detached
                  ? '${location.widget} not found after the last change'
                  : '${location.widget} · ${location.file}:${location.line}',
              style: const TextStyle(fontSize: 11, color: Colors.white54),
            ),
          const SizedBox(height: 6),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 220),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final message in comment.messages)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: message.fromAgent ? 'Agent  ' : 'You  ',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(text: message.text),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (status != CommentStatus.draft)
            _MessageField(hint: 'Reply', onSubmit: onReply),
          Wrap(
            spacing: 4,
            children: [
              if (status == CommentStatus.draft)
                TextButton(onPressed: onDelete, child: const Text('Delete')),
              if (status == CommentStatus.done)
                TextButton(
                  onPressed: () => onStatus(CommentStatus.open),
                  child: const Text('Reopen'),
                ),
              if (status != CommentStatus.draft)
                TextButton(
                  onPressed: () => onStatus(CommentStatus.resolved),
                  child: const Text('Resolve'),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Toolbar extends StatelessWidget {
  const _Toolbar({required this.children, this.color = _surface});

  final List<Widget> children;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      elevation: 6,
      borderRadius: BorderRadius.circular(24),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: children,
        ),
      ),
    );
  }
}

class _ToolbarLabel extends StatelessWidget {
  const _ToolbarLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Text(text, maxLines: 1, overflow: TextOverflow.ellipsis),
    );
  }
}

class _ToolbarButton extends StatelessWidget {
  const _ToolbarButton({
    required this.icon,
    required this.onPressed,
    this.label,
  });

  final IconData icon;
  final String? label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final label = this.label;
    if (label == null) {
      return IconButton(
        icon: Icon(icon, size: 18),
        visualDensity: VisualDensity.compact,
        onPressed: onPressed,
      );
    }

    return TextButton.icon(
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: TextButton.styleFrom(foregroundColor: Colors.white),
      onPressed: onPressed,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:widgetbook/utils/typography.dart' as util;
import 'package:google_fonts/google_fonts.dart';

class Styles {
  static const Color storyColor = Color(0xFF6C6A71);
  static const Color notCompletelyWhite = Color(0xFFECECEC);

  static Color getHighlightColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? Color(0xFFE9E8EA)
        : Color(0xFF39383C);
  }

  static const Color primary = Color(0xFFFF5610);
  static const Color secondary = Color(0xff0584FE);

  static ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(
      surface: const Color(0xffF2F1F5),
      onSurface: Color(0xff222222),
      primary: primary,
      onPrimary: Colors.black,
      primaryVariant: Color(0xffe07356),
      secondary: secondary,
      secondaryVariant: Color(0xff483F6C),
      onSecondary: Colors.white,
      background: Color(0xfff3f6f9),
      onBackground: Color(0xff222222),
    ),
    shadowColor: const Color(0xff222222).withOpacity(0.05),
    textTheme: GoogleFonts.nunitoTextTheme(
      util.Typography.textTheme,
    ),
    dividerColor: const Color(0xff6C6F8D),
    canvasColor: const Color(0x7fc3e8f3),
    scaffoldBackgroundColor: Colors.white,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        splashFactory: const BookRippleFactory(),
      ),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark(
      surface: Color(0xFF1D1B1D),
      onSurface: notCompletelyWhite,
      primary: primary,
      onPrimary: notCompletelyWhite,
      primaryVariant: Color(0xffe07356),
      secondary: secondary,
      secondaryVariant: Color(0xffB794FF),
      onSecondary: notCompletelyWhite,
      background: Colors.yellow,
      onBackground: Colors.green,
    ),
    textTheme: GoogleFonts.nunitoTextTheme(
      lightTheme.textTheme,
    ).apply(
      bodyColor: notCompletelyWhite,
      displayColor: notCompletelyWhite,
      decorationColor: notCompletelyWhite,
    ),
    hintColor: const Color(0xFFADADAD),
    shadowColor: const Color(0xff939393).withOpacity(0.05),
    dividerColor: const Color(0xff48445D),
    canvasColor: const Color(0x7f30393E),
    scaffoldBackgroundColor: Colors.black,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        splashFactory: const BookRippleFactory(),
      ),
    ),
  );
}

class BookRippleFactory extends InteractiveInkFeatureFactory {
  const BookRippleFactory();

  @override
  InteractiveInkFeature create({
    required MaterialInkController controller,
    required RenderBox referenceBox,
    required Offset position,
    required Color color,
    required TextDirection textDirection,
    bool containedInkWell = false,
    RectCallback? rectCallback,
    BorderRadius? borderRadius,
    ShapeBorder? customBorder,
    double? radius,
    VoidCallback? onRemoved,
  }) {
    return InkRipple(
      controller: controller,
      referenceBox: referenceBox,
      position: position,
      color: color,
      onRemoved: onRemoved,
    );
  }
}

const Duration _kUnconfirmedRippleDuration = Duration(seconds: 1);
const Duration _kFadeInDuration = Duration(milliseconds: 75);
const Duration _kRadiusDuration = Duration(milliseconds: 225);
const Duration _kFadeOutDuration = Duration(milliseconds: 375);
const Duration _kCancelDuration = Duration(milliseconds: 75);

class InkRipple extends InteractiveInkFeature {
  /// Begin a ripple, centered at [position] relative to [referenceBox].
  ///
  /// The [controller] argument is typically obtained via
  /// `Material.of(context)`.
  ///
  /// If [containedInkWell] is true, then the ripple will be sized to fit
  /// the well rectangle, then clipped to it when drawn. The well
  /// rectangle is the box returned by [rectCallback], if provided, or
  /// otherwise is the bounds of the [referenceBox].
  ///
  /// If [containedInkWell] is false, then [rectCallback] should be null.
  /// The ink ripple is clipped only to the edges of the [Material].
  /// This is the default.
  ///
  /// When the ripple is removed, [onRemoved] will be called.
  InkRipple({
    required MaterialInkController controller,
    required RenderBox referenceBox,
    required Offset position,
    required Color color,
    VoidCallback? onRemoved,
  })  : _position = position,
        super(
            controller: controller,
            referenceBox: referenceBox,
            color: color,
            onRemoved: onRemoved) {
    // Immediately begin fading-in the initial splash.
    _fadeInController =
        AnimationController(duration: _kFadeInDuration, vsync: controller.vsync)
          ..addListener(controller.markNeedsPaint)
          ..forward();
    _fadeIn = _fadeInController.drive(IntTween(
      begin: 0,
      end: color.alpha,
    ));

    // Controls the splash radius and its center. Starts upon confirm.
    _radiusController = AnimationController(
        duration: _kUnconfirmedRippleDuration, vsync: controller.vsync)
      ..addListener(controller.markNeedsPaint)
      ..forward();
    // Initial splash diameter is 60% of the target diameter, final
    // diameter is 10dps larger than the target diameter.

    // Controls the splash radius and its center. Starts upon confirm however its
    // Interval delays changes until the radius expansion has completed.
    _fadeOutController = AnimationController(
        duration: _kFadeOutDuration, vsync: controller.vsync)
      ..addListener(controller.markNeedsPaint)
      ..addStatusListener(_handleAlphaStatusChanged);
    _fadeOut = _fadeOutController.drive(
      IntTween(
        begin: color.alpha,
        end: 0,
      ),
    );

    controller.addInkFeature(this);
  }

  final Offset _position;

  late AnimationController _radiusController;

  late Animation<int> _fadeIn;
  late AnimationController _fadeInController;

  late Animation<int> _fadeOut;
  late AnimationController _fadeOutController;

  // static final Animatable<double> _fadeOutIntervalTween = CurveTween(curve: const Interval(_kFadeOutIntervalStart, 1.0));

  @override
  void confirm() {
    _radiusController
      ..duration = _kRadiusDuration
      ..forward();
    // This confirm may have been preceded by a cancel.
    _fadeInController.forward();
    _fadeOutController.animateTo(1.0, duration: _kFadeOutDuration);
  }

  @override
  void cancel() {
    _fadeInController.stop();
    // Watch out: setting _fadeOutController's value to 1.0 will
    // trigger a call to _handleAlphaStatusChanged() which will
    // dispose _fadeOutController.
    final double fadeOutValue = 1.0 - _fadeInController.value;
    _fadeOutController.value = fadeOutValue;
    if (fadeOutValue < 1.0)
      _fadeOutController.animateTo(1.0, duration: _kCancelDuration);
  }

  void _handleAlphaStatusChanged(AnimationStatus status) {
    if (status == AnimationStatus.completed) dispose();
  }

  @override
  void dispose() {
    _radiusController.dispose();
    _fadeInController.dispose();
    _fadeOutController.dispose();
    super.dispose();
  }

  @override
  void paintFeature(Canvas canvas, Matrix4 transform) {
    final int alpha =
        _fadeInController.isAnimating ? _fadeIn.value : _fadeOut.value;
    final Paint paint = Paint()..color = color.withAlpha(alpha);
    // Splash moves to the center of the reference box.
    final Offset center = Offset.lerp(
      _position,
      referenceBox.size.center(Offset.zero),
      Curves.ease.transform(_radiusController.value),
    )!;
    final Offset centerUnder = Offset.lerp(
      _position.scale(2, 2),
      referenceBox.size.center(Offset.zero),
      Curves.ease.transform(_radiusController.value),
    )!;
    final Offset? originOffset = MatrixUtils.getAsTranslation(transform);
    canvas.save();
    if (originOffset == null) {
      canvas.transform(transform.storage);
    } else {
      canvas.translate(originOffset.dx, originOffset.dy);
    }

    canvas.drawCircle(center, 50, paint);
    canvas.drawCircle(centerUnder, 100, paint);
    canvas.restore();
  }
}

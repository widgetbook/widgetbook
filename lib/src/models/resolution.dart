class Resolution {
  final double width;
  final double height;
  double get widthInPt => width / scaleFactor;
  double get heightInPt => height / scaleFactor;
  final double scaleFactor;

  const Resolution({
    required this.width,
    required this.height,
    required this.scaleFactor,
  });
}

class ImageMetadata {
  const ImageMetadata({
    required this.path,
    required this.hash,
    required this.size,
    required this.width,
    required this.height,
    required this.pixelRatio,
  });

  final String path;
  final String hash;
  final int size;
  final int width;
  final int height;
  final double pixelRatio;

  // ignore: sort_constructors_first
  factory ImageMetadata.fromJson(Map<String, dynamic> json) {
    return ImageMetadata(
      path: json['path'] as String,
      hash: json['hash'] as String,
      size: json['size'] as int,
      width: json['width'] as int,
      height: json['height'] as int,
      pixelRatio: json['pixelRatio'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'path': path,
      'hash': hash,
      'size': size,
      'width': width,
      'height': height,
      'pixelRatio': pixelRatio,
    };
  }
}

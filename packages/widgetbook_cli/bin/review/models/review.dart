class Review {
  const Review({
    required this.id,
  });

  final String id;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
    };
  }

  // ignore: sort_constructors_first
  factory Review.fromJson(Map<String, dynamic> map) {
    return Review(
      id: map['id'] as String,
    );
  }
}

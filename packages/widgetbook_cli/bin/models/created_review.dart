class CreatedReview {
  const CreatedReview({
    required this.id,
  });

  final String id;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
    };
  }

  // ignore: sort_constructors_first
  factory CreatedReview.fromJson(Map<String, dynamic> map) {
    return CreatedReview(
      id: map['id'] as String,
    );
  }
}

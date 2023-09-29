class Comment {
  const Comment({
    required this.body,
  });

  final String body;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'body': body,
    };
  }

  // ignore: sort_constructors_first
  factory Comment.fromJson(Map<String, dynamic> map) {
    return Comment(
      body: map['body'] as String,
    );
  }
}

class ReviewModel {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;

  ReviewModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  ReviewModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? createdAt,
  }) {
    return ReviewModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

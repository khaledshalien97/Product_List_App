class ReviewModel {
  final int rating;
  final String comment;
  final DateTime date;
  final String reviewerName;
  final String reviewerEmail;

  ReviewModel({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> j) => ReviewModel(
    rating: (j['rating'] as num?)?.toInt() ?? 0,
    comment: j['comment'] ?? '',
    date: DateTime.tryParse(j['date'] ?? '') ?? DateTime.now(),
    reviewerName: j['reviewerName'] ?? 'Anonymous',
    reviewerEmail: j['reviewerEmail'] ?? '',
  );
}

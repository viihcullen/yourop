class Content {
  final String title;
  final String authorsOrProducers;
  final int releaseYear;
  final String imageUrl;
  final String nationality;
  final String creator;
  final List<String> categories;
  final List<String> genre;
  final String description;
  final String betaReview;
  final List<Comment> comments;
  final List<double> ratings;

  Content({
    required this.title,
    required this.authorsOrProducers,
    required this.releaseYear,
    required this.imageUrl,
    required this.nationality,
    required this.creator,
    required this.categories,
    required this.genre,
    required this.description,
    required this.betaReview,
    required this.comments,
    this.ratings = const [],
  });
}

class Comment {
  final String username;
  final String text;

  Comment({
    required this.username,
    required this.text,
  });
}

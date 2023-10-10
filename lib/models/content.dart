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
  final List<Comment> comments;
  final List<double> userRatings;
  final List<double> metaRatings;
  final List<MetaReview> metaReviews;

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
    required this.comments,
    this.userRatings = const [],
    this.metaRatings = const [],
    this.metaReviews = const []
  });
}

class MetaReview{
  final String titulo;
  final double valorAvaliacaoGeral;
  final String comentarioAvaliativo;
  MetaReview({
    required this.titulo,
    required this.valorAvaliacaoGeral,
    required this.comentarioAvaliativo
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

class Article {
  final int id; // identifiant de l’article
  final String title; // titre de l’article
  final String body; // contenu (texte)

  Article({
    required this.id,
    required this.title,
    required this.body,
  });

  // construit un Article à partir d’un JSON
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

// modèle de données pour représenter un article

class Article {
  final int id; // identifiant de l’article (unique)
  final String title; // titre de l’article
  final String body; // contenu (texte complet)

  // constructeur : permet de créer un article avec ses 3 champs obligatoires
  Article({
    required this.id,
    required this.title,
    required this.body,
  });

  // factory constructor : transforme un JSON (Map) en objet Article
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'], // récupère l'id dans le JSON
      title: json['title'], // récupère le titre
      body: json['body'], // récupère le contenu
    );
  }
}

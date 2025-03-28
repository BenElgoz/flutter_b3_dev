import 'package:flutter/material.dart'; 
import '../models/article.dart'; // modèle Article

class ArticleDetailPage extends StatelessWidget {
  final Article article; // l'article à afficher, transmis depuis la liste

  const ArticleDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Article ${article.id}'), // affiche l’ID dans la barre du haut
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.title, // titre de l’article
              style: const TextStyle(
                fontSize: 24, 
                fontWeight: FontWeight.bold, 
              ),
            ),
            const SizedBox(height: 16), 
            Text(
              article.body, // contenu de l’article
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
